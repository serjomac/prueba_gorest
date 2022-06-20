//
//  PostsServiceProtocol.swift
//  testgorest
//
//  Created by Jonathan Macias on 20/6/22.
//

import Foundation

protocol PostsServiceProtocol {
    func fetchPosts(_ urlString: String, page: Int, completion: @escaping (Result<PostResponse, Error>) -> Void)
}
