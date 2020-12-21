//
//  UserNameTableViewCell.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

class UserNameTableViewCell: UITableViewCell {

    static var identifier: String = "UserNameTableViewCell"
    
    //MARK:- Outlets.
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
