//
//  ReviewsListPresenter.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation
import RxSwift

protocol ReviewsListPresenterProtocol {
    func getTheReviews()
    func showReviewDetail(itemId: Int)
}

class ReviewsListPresenter: ReviewsListPresenterProtocol {
    
    private var viewModel: ReviewsListViewModel
    private var interactor: ReviewsInteractorProtocol
    private var wireframe: ReviewsWireframe?
    private let disposeBag = DisposeBag()
    
    init(sourceVM: ReviewsListViewModel) {
        viewModel = sourceVM
        let navigation = (viewModel as? UIViewController)?.navigationController
        wireframe = ReviewsWireframe(with: navigation)
        interactor = ReviewsInteractor()
    }
    
    func getTheReviews() {
        viewModel.showLoader()
        interactor.fetchReviews()
            .observeOn(MainScheduler.instance)
            .asObservable().subscribe(
            onNext: { [weak self] someResult in
                guard let self = self else { return }
                self.viewModel.setReviews(reviews: someResult)
                self.viewModel.hideLoader()
            },
            onError: { [weak self] error in
                self?.viewModel.showError(errorMessage: error.localizedDescription)
                self?.viewModel.hideLoader()
            }).disposed(by: disposeBag)
    }
    
    func showReviewDetail(itemId: Int) {
        wireframe?.showReviewDetail(itemId: itemId)
    }
}
