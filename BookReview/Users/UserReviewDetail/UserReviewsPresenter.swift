//
//  UserReviewsPresenter.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit
import RxSwift

protocol UserReviewsPresenterLogic {
    func getUserReviews(with userId: Int)
}

class UserReviewsPresenter: UserReviewsPresenterLogic {
    
    private var viewModel: UserReviewsViewModel
    private let interactor: UsersInteractorLogic
    private let wireframe: UsersWireframe
    private let disposeBag = DisposeBag()
    
    init(with sourceVM: UserReviewsViewModel) {
        viewModel = sourceVM
        let navigation = (sourceVM as? UIViewController)?.navigationController
        wireframe = UsersWireframe(with: navigation)
        interactor = UsersInteractor()
    }
    
    func getUserReviews(with userId: Int) {
        viewModel.showLoader()
        interactor.getTheReviewsForUser(with: userId)
            .observeOn(MainScheduler.instance)
            .asObservable().subscribe(
            onNext: { [weak self] reviewsData in
                guard let self = self else { return }
                self.viewModel.showUserReviews(reviewsForUser: reviewsData)
                self.viewModel.hideLoader()
            },
            onError: { [weak self] error in
                self?.viewModel.showError(errorMessage: error.localizedDescription)
                self?.viewModel.hideLoader()
            }).disposed(by: disposeBag)
    }

}
