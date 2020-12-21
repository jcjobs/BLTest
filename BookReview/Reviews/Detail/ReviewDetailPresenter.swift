//
//  ReviewDetailPresenter.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation
import RxSwift

protocol ReviewDetailPresenterProtocol {
    func getDetailReview(with reviewId: Int)
}

class ReviewDetailPresenter: ReviewDetailPresenterProtocol {
    
    private var viewModel: ReviewDetailViewModel
    private var interactor: ReviewsInteractorProtocol
    private let disposeBag = DisposeBag()
    
    init(sourceVM: ReviewDetailViewModel) {
        viewModel = sourceVM
        interactor = ReviewsInteractor()
    }
    
    func getDetailReview(with reviewId: Int) {
        viewModel.showLoader()
        interactor.getDetailReview(with: reviewId)
            .observeOn(MainScheduler.instance)
            .asObservable().subscribe(
            onNext: { [weak self] someResult in
                guard let self = self else { return }
                self.viewModel.showReviewDetail(title: someResult.title, body: someResult.body)
                self.viewModel.hideLoader()
            },
            onError: { [weak self] error in
                self?.viewModel.showError(errorMessage: error.localizedDescription)
                self?.viewModel.hideLoader()
            }).disposed(by: disposeBag)
    }
}
