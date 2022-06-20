//
//  PostDetailPresenter.swift
//  testgorest
//
//  Created by Jonathan Macias on 19/6/22.
//

import Foundation

class PostDetailPresenter: ViewToPresentPostDetailProtocol {
    var view: PresenterToViewPostDetailProtocol?
    
    var interactor: PresentToInteractorDetailPostsProtocol?
    
    var router: PresenterToRouterDetailPostsProtocol?
    
    
}

extension PostDetailPresenter: InteractorToPresentDetailPostsProtocol {
    
}
