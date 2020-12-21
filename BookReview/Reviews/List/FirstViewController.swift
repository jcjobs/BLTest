//
//  FirstViewController.swift
//  BookReview
//
//  Created by Angel Casado on 2/1/16.
//  Copyright © 2016 Televisa. All rights reserved.
//

import UIKit

protocol ReviewsListViewModel: BaseViewModel {
    func setReviews(reviews: [ReviewsData])
    func showError(errorMessage: String)
}

class FirstViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!

    //MARK:- Constant and variables
    private var reviews: [ReviewsData] = [ReviewsData]()
    private var presenter: ReviewsListPresenterProtocol?
    
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Reviews"
        getTheReviews()
    }
    
}

private extension FirstViewController {
    //MARK:- Functions
    func setup() {
        presenter = ReviewsListPresenter(sourceVM: self)
    }
    
    func getTheReviews() {
        presenter?.getTheReviews()
    }
}

extension FirstViewController: ReviewsListViewModel {
    
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func setReviews(reviews: [ReviewsData]) {
        self.reviews = reviews
        self.tableView.reloadData()
        self.tableView.updateConstraintsIfNeeded()
        self.tableView.autoresizesSubviews = true
    }
    
    func showError(errorMessage: String) {
        showAlert(with: errorMessage)
    }
}

//MARK:- TableView Protocols
extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath as IndexPath) as! ReviewsTableViewCell
      
        cell.accessoryType = .disclosureIndicator
        cell.bodyReview.text = reviews[indexPath.row].title + "\n" + "\n" + reviews[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showReviewDetail(itemId: reviews[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
