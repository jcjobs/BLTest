//
//  UserListPresenter.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation
import RxSwift

protocol UserListPresenterLogic {
    func getTheUsers()
    func showUserDetail(with userId: Int, and userName: String)
}

class UserListPresenter: UserListPresenterLogic {
    
    private var viewModel: UsersViewModel
    private let interactor: UsersInteractorLogic
    private let wireframe: UsersWireframe
    private let disposeBag = DisposeBag()
    
    init(with sourceVM: UsersViewModel) {
        viewModel = sourceVM
        let navigation = (sourceVM as? UIViewController)?.navigationController
        wireframe = UsersWireframe(with: navigation)
        interactor = UsersInteractor()
    }
    
    func getTheUsers() {
        viewModel.showLoader()
        interactor.fetchUsers()
            .observeOn(MainScheduler.instance)
            .asObservable().subscribe(
            onNext: { [weak self] usersData in
                guard let self = self else { return }
                self.viewModel.showUsers(userData: usersData)
                self.viewModel.hideLoader()
            },
            onError: { [weak self] error in
                self?.viewModel.showError(errorMessage: error.localizedDescription)
                self?.viewModel.hideLoader()
            }).disposed(by: disposeBag)
    }
    
    func showUserDetail(with userId: Int, and userName: String) {
        wireframe.showUserDetailView(with: userId, and: userName)
    }
}
