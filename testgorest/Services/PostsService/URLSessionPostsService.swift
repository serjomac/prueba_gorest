//
//  URLSessionPostsService.swift
//  testgorest
//
//  Created by Jonathan Macias on 20/6/22.
//

import Foundation

class URLSessionPostsService: PostsServiceProtocol {
    func fetchPosts(_ urlString: String, page: Int, completion: @escaping (Result<PostResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(PostResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
}
