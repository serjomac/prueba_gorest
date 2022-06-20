//
//  AFPostsService.swift
//  testgorest
//
//  Created by Jonathan Macias on 20/6/22.
//

import Foundation
import Alamofire

class AFPostsService: PostsServiceProtocol {
    func fetchPosts(_ urlString: String, page: Int, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        AF.request("\(Endpoints.URL_API)/posts", method: .get, parameters: ["page": page]).responseDecodable(of: PostResponse.self, queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
                case let .success(data):
                completion(.success(data))
//                self.presenter?.fetchPostsSuccess(postsResponse: data)
            case let .failure(error):
                completion(.failure(error))
//                self.presenter?.fetchPostsFailure(message: error.errorDescription ?? "SERVICIO NO DISPONIBLE")
            }
        }
    }
    
}
