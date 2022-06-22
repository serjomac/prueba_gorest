//
//  PostsViewController.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: OULETS
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var searchPosts: UISearchBar!
    @IBOutlet weak var reloadItem: UIBarButtonItem!
    
    // MARK: VARIABLES
    var postsPresenter: ViewToPresentePostsProtocol?
    var postsResponse: PostResponse?
    var postsFiltered: [Post] = []
    var isLoading = false
    var typeServiceSelected: TypeService = .alamofire

    // MARK: - CICLO DE VIDA
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVew()
        reloadPosts(typeService: typeServiceSelected)
        isLoading = true
    }
    
    // CONFIGURAR ELEMENTO DE LA VISTA
    func setupVew() {
        postsTableView.delegate = self
        postsTableView.dataSource = self
        searchPosts.delegate = self
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 200
        let tableViewCellNib = UINib(nibName: "PostViewCell", bundle: nil)
        postsTableView.register(tableViewCellNib, forCellReuseIdentifier: "postCell")
        setupMenu()
    }
    
    var isSearchBarEmpty: Bool {
      return searchPosts.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return !isSearchBarEmpty
    }
    // SOLICITAR MÁS POSTS Y ADICIONARLOS A LA LISTA DE POSTS RESPONSE, EN CASO DE SER LA PRIMEA VEZ SOLICITAR LA PRIMERA PÁGINA
    // E INSTNACIAR EL POSTRESPONSE CON LOS PRIMEROS POSTS
    func reloadPosts(typeService: TypeService) {
        isLoading = true
        postsTableView.tableFooterView = createActivityIndicatorFooter()
        guard let postResponse = postsResponse else {
            postsPresenter?.refresh(page: 1, typeService: typeService)
            return
        }
        postsPresenter?.refresh(page: postResponse.meta.pagination.page + 1, typeService: typeService)
    }
    
    func setupMenu() {
        let alamofireItemMenu = UIAction(title: "Alamofire", image: UIImage(systemName: "arrow.clockwise")) { (action) in
            self.postsResponse = nil
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
            self.reloadPosts(typeService: .alamofire)
        }
        let urlSessionItemMenu = UIAction(title: "URLSession", image: UIImage(systemName: "arrow.clockwise")) { (action) in
            self.postsResponse = nil
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
            self.reloadPosts(typeService: .urlsession)
        }
        let menu = UIMenu(title: "Tipo de servicio", children: [alamofireItemMenu, urlSessionItemMenu])
        reloadItem.menu = menu
    }
    
}

// MARK: PROTOCOLO DEL PRESENTER A LA VISTA
extension PostsViewController: PresenterToViewPostProtocol {
    func onPostSearchResults(posts: [Post]) {
        postsFiltered = posts
        DispatchQueue.main.async {[weak self]in
            self?.postsTableView.reloadData()
        }
    }
    
    func onPostFetchSucces(postResponse: PostResponse) {
        isLoading = false
        guard let _ = self.postsResponse else {
            self.postsResponse = postResponse
            DispatchQueue.main.async {[weak self]in
                self?.postsTableView.tableFooterView = nil
                self?.postsTableView.reloadData()
            }
            return
        }
        self.postsResponse?.data += postResponse.data
        self.postsResponse?.meta = postResponse.meta
        DispatchQueue.main.async {[weak self]in
            self?.postsTableView.tableFooterView = nil
            self?.postsTableView.reloadData()
         
        }
    }
    
    func onPostFetchError(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    // MARK: TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? postsFiltered.count : postsResponse?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostViewCell
        cell.titlePost.text = postsResponse!.data[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postsPresenter?.router?.pushToPostDetail(navigationController: navigationController!, post: postsResponse!.data[indexPath.row])
    }
    
    // IDENTIFICAR CUANDO LA TABLA LLEGÓ AL FINAL PARA SOLICITAR MÁS POSTS
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let postsResponse = self.postsResponse else {
            return
        }
        let position = scrollView.contentOffset.y
        if position > (postsTableView.contentSize.height-50 - scrollView.frame.size.height), !isLoading, postsResponse.meta.pagination.page != postsResponse.meta.pagination.pages {
            reloadPosts(typeService: typeServiceSelected)
        }
    }
    
    // MARK: SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        postsPresenter?.searchPost(query: searchText, posts: postsResponse!.data)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPosts.resignFirstResponder()
    }
    
    func createActivityIndicatorFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return footerView
    }
}
