//
//  UsersWireframe.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class UsersWireframe: NSObject {
    
    private weak var navigation: UINavigationController?

    init(with sourceNavigation: UINavigationController?) {
        navigation = sourceNavigation
    }
    
    func showUserDetailView(with userId: Int, and userName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UserReviewDetailViewController") as? UserReviewDetailViewController else { return }
        vc.userId = userId
        vc.userName = userName
        navigation?.pushViewController(vc, animated: true)
    }
    
}
