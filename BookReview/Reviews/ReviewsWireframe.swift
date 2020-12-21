//
//  ReviewsWireframe.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class ReviewsWireframe: NSObject {
    
    private weak var navigation: UINavigationController?
    
    init(with sourceNavigation: UINavigationController?) {
        navigation = sourceNavigation
    }
    
    func showReviewDetail(itemId: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController else { return }
        vc.idPost = itemId
        navigation?.pushViewController(vc, animated: true)
    }
}
