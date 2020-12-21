//
//  ReviewsInteractor.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation
import RxSwift

protocol ReviewsInteractorProtocol {
    func fetchReviews()  -> Single<[ReviewsData]>
    func getDetailReview(with reviewId: Int) -> Single<ReviewDetailResponse>
}

class ReviewsInteractor: ReviewsInteractorProtocol {
    
    let apiManager: APIManagerPrototol = APIManager()
    
    func fetchReviews()  -> Single<[ReviewsData]> {
        return Single.create { single in
            self.apiManager.getTheReviews { response in
                single(.success(response.data))
            } onError: { error in
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func getDetailReview(with reviewId: Int) -> Single<ReviewDetailResponse> {
        return Single.create { single in
            self.apiManager.getDetailReview(id: reviewId) { response in
                single(.success(response))
            } onError: { error in
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
}
