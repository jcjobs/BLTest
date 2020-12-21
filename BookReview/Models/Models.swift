//
//  Models.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import Foundation

struct UsersResponse {
    var data : [UsersData] = [UsersData]()
   
}
struct UsersData {
    var name: String = ""
    var id: Int = 0
    
}

struct ReviewsResponse {
    var data : [ReviewsData] = [ReviewsData]()
    
}
struct ReviewsData {
    var title: String = ""
    var body: String = ""
    var id: Int = 0 
    
}


struct ReviewDetailResponse {
  
    var title : String = ""
    var body : String = ""

}


    
    




