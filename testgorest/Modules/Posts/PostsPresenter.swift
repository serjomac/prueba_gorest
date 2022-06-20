//
//  PostsPresenter.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import Foundation
import UIKit

class PostsPresenter: ViewToPresentePostsProtocol {
    var view: PresenterToViewPostProtocol?
    var interactor: PresentToInteractorPostsProtocol?
    var router: PresenterToRouterPostsProtocol?
    
    func refresh(page: Int, typeService: TypeService) {
        interactor?.fetchPosts(page: page, typeService: typeService)
    }
    
    func showDetailViewController(navigationController: UINavigationController, post: Post) {
        router?.pushToPostDetail(navigationController: navigationController, post: post)
    }
    
    func searchPost(query: String, posts: [Post]) {
        interactor?.searchPosts(query: query, post: posts)
    }
}

extension PostsPresenter: InteractorToPresentPostsProtocol {
    
    func fetchPostsSuccess(postsResponse: PostResponse) {
        view?.onPostFetchSucces(postResponse: postsResponse)
    }
    
    func fetchPostsFailure(message: String) {
        view?.onPostFetchError(message: message)
    }
    
    func searchPostsSuccess(posts: [Post]) {
        view?.onPostSearchResults(posts: posts)
    }
    
    
}
