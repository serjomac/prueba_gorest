//
//  PostDetailProtocol.swift
//  testgorest
//
//  Created by Jonathan Macias on 19/6/22.
//

import Foundation
import UIKit

protocol ViewToPresentPostDetailProtocol {
    var view: PresenterToViewPostDetailProtocol? { get set }
    var interactor: PresentToInteractorDetailPostsProtocol? { get set }
    var router: PresenterToRouterDetailPostsProtocol? { get set }
}

// MARK: - ViewOutput (Present -> View)
protocol PresenterToViewPostDetailProtocol {
}

// MARK: - Interactor Input (Present -> Interactor)
protocol PresentToInteractorDetailPostsProtocol {
    var presenter: InteractorToPresentDetailPostsProtocol? { get set }
    var post: Post? { get set }
}

// MARK: - Interactor Output (Interactor -> Present)
protocol InteractorToPresentDetailPostsProtocol {
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterDetailPostsProtocol {
    static func createModule(post: Post) -> PostDetailViewController
}


