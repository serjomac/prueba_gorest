//
//  PostsProtocol.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import Foundation
import UIKit


// MARK: - View Input (View -> Presenter)
protocol ViewToPresentePostsProtocol {
    var view: PresenterToViewPostProtocol? { get set }
    var interactor: PresentToInteractorPostsProtocol? { get set }
    var router: PresenterToRouterPostsProtocol? { get set }
    func refresh(page: Int, typeService: TypeService)
    func searchPost(query: String, posts: [Post])
    func showDetailViewController(navigationController:UINavigationController, post: Post)
}

// MARK: - ViewOutput (Present -> View)
protocol PresenterToViewPostProtocol {
    func onPostFetchSucces(postResponse: PostResponse)
    func onPostSearchResults(posts: [Post])
    func onPostFetchError(message: String)
}

// MARK: - Interactor Input (Present -> Interactor)
protocol PresentToInteractorPostsProtocol {
    var presenter: InteractorToPresentPostsProtocol? { get set }
    func fetchPosts(page: Int, typeService: TypeService)
    func searchPosts(query: String, post: [Post])
}

// MARK: - Interactor Output (Interactor -> Present)
protocol InteractorToPresentPostsProtocol {
    func fetchPostsSuccess(postsResponse: PostResponse)
    func fetchPostsFailure(message: String)
    func searchPostsSuccess(posts: [Post])
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterPostsProtocol {
    static func createModule() -> PostsViewController
    func pushToPostDetail(navigationController: UINavigationController, post: Post)
}
