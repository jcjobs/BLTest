//
//  UsersInteractor.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersInteractorLogic {
    func fetchUsers() -> Single<[UsersData]>
    func getTheReviewsForUser(with userId: Int) -> Single<[ReviewsData]>
}

class UsersInteractor: UsersInteractorLogic {
    
    let apiManager: APIManagerPrototol = APIManager()

    func fetchUsers() -> Single<[UsersData]> {
        return Single.create { single in
            self.apiManager.getTheUsers { response in
                single(.success(response.data))
            } onError: { error in
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func getTheReviewsForUser(with userId: Int) -> Single<[ReviewsData]> {
        return Single.create { single in
            self.apiManager.getTheReviewsForUser(id: userId) { response in
                single(.success(response.data))
            } onError: { error in
                single(.error(error))
            }

            return Disposables.create()
        }
    }
    
}
