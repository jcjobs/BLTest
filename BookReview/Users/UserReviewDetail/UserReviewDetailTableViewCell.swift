//
//  UserReviewDetailTableViewCell.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 2/1/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

class UserReviewDetailTableViewCell: UITableViewCell {
    
    static let identifier = "UserReviewDetailTableViewCell"

    //MARK:- Outlets
    
    @IBOutlet weak var reviewDetail: UITextView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
