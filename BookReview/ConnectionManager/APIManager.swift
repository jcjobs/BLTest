//
//  APIManager.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol APIManagerPrototol {
    func getTheUsers(onSuccess: @escaping(UsersResponse) -> (), onError: @escaping(Error) -> ())
    func getTheReviewsForUser(id: Int, onSuccess: @escaping(ReviewsResponse) -> Void, onError: @escaping(Error) -> ())
    func getTheReviews(onSuccess: @escaping(ReviewsResponse) -> (), onError: @escaping(Error) -> ())
    func getDetailReview(id: Int, onSuccess: @escaping(ReviewDetailResponse) -> Void, onError: @escaping(Error) -> ())
}

class APIManager: NSObject {
    
    //Set the main URL
    private let USER_URL = "http://jsonplaceholder.typicode.com/users"
    private let REVIEWS_URL = "http://jsonplaceholder.typicode.com/posts"
    
    private func makeRequest(with urlString: String, completion: @escaping(Result<Data?, NetworkingError>) -> ()) {
    
        guard ReachabilityManager.isConnectedToNetwork() else {
            completion(.failure(.noInternetConnection))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            guard let errorResult = error else {
                completion(.success(data))
                return
            }

            completion(.failure(.domainError(description: errorResult.errorMessage, errorCode: errorResult.code)))
        })
        task.resume()
    }
    
}

extension APIManager: APIManagerPrototol {
    
    //Display all the users
    func getTheUsers(onSuccess: @escaping(UsersResponse) -> (), onError: @escaping(Error) -> ()) {
        
        var usersResponse : UsersResponse = UsersResponse()
    
        makeRequest(with: USER_URL) { result in
            switch result {
            case .success(let data):
    
                if let dataFromNetworking = data {
                    if let json = try? JSON(data: dataFromNetworking){
                        for (_, subJson):(String, JSON) in json {
                            var user : UsersData = UsersData()
                            user.id = subJson["id"].intValue
                            user.name = subJson["name"].stringValue
                            
                            usersResponse.data.append(user)
                        }
                    }
                }
                
                onSuccess(usersResponse)
                
            case .failure(let error):
                onError(error)
            }
        }
        
    }
    
    //Display all the reviews.
    func getTheReviews(onSuccess: @escaping(ReviewsResponse) -> (), onError: @escaping(Error) -> ()) {
        
        var reviewsResponse : ReviewsResponse = ReviewsResponse()
        
        makeRequest(with: REVIEWS_URL) { result in
            switch result {
            case .success(let data):
                
                if let dataFromNetworking = data {
                    if let json = try? JSON(data: dataFromNetworking){
                        for (_, subJson):(String, JSON) in json {
                            var reviews : ReviewsData = ReviewsData()
                            reviews.title = subJson["title"].stringValue
                            reviews.body = subJson["body"].stringValue
                            reviews.id = subJson["id"].intValue
                            
                            reviewsResponse.data.append(reviews)
                        }
                    }
                }
                
                onSuccess(reviewsResponse)
                
            case .failure(let error):
                onError(error)
            }
        }
        
    }
    
    //Display the Detail of the review
    func getDetailReview(id: Int, onSuccess: @escaping(ReviewDetailResponse) -> Void, onError: @escaping(Error) -> ()) {
        
        var reviewsDetailResponse : ReviewDetailResponse = ReviewDetailResponse()
        
        makeRequest(with: "\(REVIEWS_URL)/\(id)") { result in
            switch result {
            case .success(let data):
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>
                        if let title = json["title"] as? String {
                            reviewsDetailResponse.title = title
                        }
                        if let body = json["body"] as? String {
                            reviewsDetailResponse.body = body
                        }
     
                        onSuccess(reviewsDetailResponse)
                    } catch {
                        onSuccess(reviewsDetailResponse)
                    }
                }
                
            case .failure(let error):
                onError(error)
            }
        }
        
    }
    
    
    //Display the reviews by user.
    func getTheReviewsForUser(id: Int, onSuccess: @escaping(ReviewsResponse) -> Void, onError: @escaping(Error) -> ()) {
        
        var reviewsResponse : ReviewsResponse = ReviewsResponse()
        
        makeRequest(with: "\(USER_URL)/\(id)/posts") { result in
            switch result {
            case .success(let data):
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String,AnyObject>]
                        print(json)
                        
                        
                        for element in json {
                            var reviews : ReviewsData = ReviewsData()
                            if let title = element["title"] as? String {
                                reviews.title = title
                            }
                            
                            if let body = element["body"] as? String {
                                reviews.body = body
                            }
                            
                            if let id = element["id"] as? Int {
                                reviews.id = id
                            }
                            
                            reviewsResponse.data.append(reviews)
                        }
                        
                        onSuccess(reviewsResponse)
                    } catch {
                        onSuccess(reviewsResponse)
                    }
                }
                
            case .failure(let error):
                onError(error)
            }
        }
        
    }
    
}
