//
//  PostsService.swift
//  testgorest
//
//  Created by Jonathan Macias on 20/6/22.
//

import Foundation

class PostsService {
    private let webService: PostsServiceProtocol
    
    init(webService: PostsServiceProtocol) {
        self.webService = webService
    }
    
    func fetchPosts(apiURL: String, page: Int, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        webService.fetchPosts(apiURL, page: page) { response in
            switch response {
                case .success(let postRes):
                completion(.success(postRes))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
