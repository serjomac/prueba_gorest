//
//  PostDetailRouter.swift
//  testgorest
//
//  Created by Jonathan Macias on 19/6/22.
//

import Foundation
import UIKit

class PostDetailRouter: PresenterToRouterDetailPostsProtocol {
    static func createModule(post: Post) -> PostDetailViewController {
        let viewC = PostDetailRouter.mainstoryboard.instantiateViewController(withIdentifier: "postDetail") as! PostDetailViewController
        let presenter: ViewToPresentPostDetailProtocol & InteractorToPresentDetailPostsProtocol = PostDetailPresenter()
        let interactor: PresentToInteractorDetailPostsProtocol = PostDetailInteractor()
        let router: PresenterToRouterDetailPostsProtocol = PostDetailRouter()
        viewC.post = post
        viewC.presenter = presenter
        viewC.presenter?.view = viewC
        viewC.presenter?.router = router
        viewC.presenter?.interactor = interactor
        viewC.presenter?.interactor?.presenter = presenter
        
        return viewC
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
