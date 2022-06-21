//
//  PostDetailProtocol.swift
//  testgorest
//
//  Created by Jonathan Macias on 19/6/22.
//

import Foundation
import UIKit

protocol ViewToPresentPostDetailProtocol: AnyObject {
    var view: PresenterToViewPostDetailProtocol? { get set }
    var interactor: PresentToInteractorDetailPostsProtocol? { get set }
    var router: PresenterToRouterDetailPostsProtocol? { get set }
}

// MARK: - ViewOutput (Present -> View)
protocol PresenterToViewPostDetailProtocol: AnyObject {
}

// MARK: - Interactor Input (Present -> Interactor)
protocol PresentToInteractorDetailPostsProtocol: AnyObject {
    var presenter: InteractorToPresentDetailPostsProtocol? { get set }
    var post: Post? { get set }
}

// MARK: - Interactor Output (Interactor -> Present)
protocol InteractorToPresentDetailPostsProtocol: AnyObject {
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterDetailPostsProtocol: AnyObject {
    static func createModule(post: Post) -> PostDetailViewController
}


