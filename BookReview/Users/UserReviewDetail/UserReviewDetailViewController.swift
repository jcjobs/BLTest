//
//  UserReviewDetailViewController.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 2/1/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

protocol UserReviewsViewModel: BaseViewModel {
    func showUserReviews(reviewsForUser: [ReviewsData])
    func showError(errorMessage: String)
}

class UserReviewDetailViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables and constants
    var reviewsForUser: [ReviewsData] = [ReviewsData]()
    var userId: Int = 0
    var userName: String = ""
    
    private var presenter: UserReviewsPresenterLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Call the function
        getTheReviewsForUser()
    }

}

private extension UserReviewDetailViewController {
    func setup() {
        presenter = UserReviewsPresenter(with: self)
    }
    
    func setupUI() {
        //Set delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Set the navigation title.
        navigationItem.title = "Reviews by \(userName)"
    }
    
    func getTheReviewsForUser() {
        presenter?.getUserReviews(with: userId)
    }
}

extension UserReviewDetailViewController: UserReviewsViewModel {
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func showUserReviews(reviewsForUser: [ReviewsData]) {
        self.reviewsForUser = reviewsForUser
        self.tableView.reloadData()
        
        //Update the constrains after the data is received depending the size content.
        self.tableView.updateConstraintsIfNeeded()
        
        //Resize the subViews.
        self.tableView.autoresizesSubviews = true
    }
    
    func showError(errorMessage: String) {
        showAlert(with: errorMessage)
    }
}

//MARK:- TablViewProtocols
extension UserReviewDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsForUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserReviewDetailTableViewCell.identifier, for: indexPath as IndexPath) as! UserReviewDetailTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        cell.reviewDetail.text = reviewsForUser[indexPath.row].title + "\n" + "\n" + reviewsForUser[indexPath.row].body
        return cell
    }
    
    //Set the size of the cell depending the content size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
