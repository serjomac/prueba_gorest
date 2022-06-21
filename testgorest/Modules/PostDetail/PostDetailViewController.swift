//
//  PostDetailViewController.swift
//  testgorest
//
//  Created by Jonathan Macias on 19/6/22.
//

import UIKit

class PostDetailViewController: UIViewController {

    // MARK: - OULETS
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    var presenter: ViewToPresentPostDetailProtocol?
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("POST: \(post?.title) \(post?.description)")
        postTitle.text = post?.title ?? ""
        postDescription.text = post?.description ?? ""
    }

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    deinit {
        print("DESTRUCTROR")
    }
}

extension PostDetailViewController: PresenterToViewPostDetailProtocol {
    
}
