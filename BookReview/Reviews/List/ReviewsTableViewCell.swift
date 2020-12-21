//
//  ReviewsTableViewCell.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    static var identifier: String = "ReviewsTableViewCell"

    //MARK:- Outlets.
    
    @IBOutlet weak var bodyReview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
