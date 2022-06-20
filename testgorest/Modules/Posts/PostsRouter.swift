//
//  PostsRouter.swift
//  testgorest
//
//  Created by Jonathan Macias on 17/6/22.
//

import Foundation
import UIKit

class PostRouter: PresenterToRouterPostsProtocol {
    static func createModule() -> PostsViewController {
        let viewController = PostRouter.mainstoryboard.instantiateViewController(withIdentifier: "posts") as! PostsViewController
        
        let presenter: ViewToPresentePostsProtocol & InteractorToPresentPostsProtocol = PostsPresenter()
        let interactor: PresentToInteractorPostsProtocol = PostsInteractor()
        let router: PresenterToRouterPostsProtocol = PostRouter()
        
        viewController.postsPresenter = presenter
        viewController.postsPresenter?.view = viewController
        viewController.postsPresenter?.router = router
        viewController.postsPresenter?.interactor = interactor
        viewController.postsPresenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func pushToPostDetail(navigationController: UINavigationController, post: Post) {
        let postDetailModule = PostDetailRouter.createModule(post: post)
        navigationController.pushViewController(postDetailModule, animated: true)
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
