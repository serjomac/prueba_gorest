//
//  PostsInteractor.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import Foundation
import Alamofire

class PostsInteractor: PresentToInteractorPostsProtocol {
    
    var presenter: InteractorToPresentPostsProtocol?
    
    func fetchPosts(page: Int, typeService: TypeService) {
        let postsService: PostsService
        if typeService == .alamofire {
            postsService = PostsService(webService: AFPostsService())
        } else {
            postsService = PostsService(webService: URLSessionPostsService())
        }
        postsService.fetchPosts(apiURL: "\(Endpoints.URL_API)/posts", page: page) { response in
            switch response {
                case .success(let data):
                    self.presenter?.fetchPostsSuccess(postsResponse: data)
                case .failure(let error):
                    self.presenter?.fetchPostsFailure(message: error.asAFError?.errorDescription ?? "SERVICIO NO DISPONIBLE")
            }
        }
    }
    
    func searchPosts(query: String, post: [Post]) {
        let filteredPosts = query.isEmpty ? post : post.filter({ item in
            return item.title.lowercased().contains(query.lowercased())
        })
        self.presenter?.searchPostsSuccess(posts: filteredPosts)
    }
}
