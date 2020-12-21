//
//  ReviewsViewController.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

protocol ReviewDetailViewModel: BaseViewModel {
    func showReviewDetail(title: String, body: String)
    func showError(errorMessage: String)
}

class ReviewsViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var detailReviewTxt: UITextView!
    @IBOutlet weak var titleDetail: UILabel!
    
    //MARK:- Variables and Constants
    var idPost: Int = 0
    private var presenter: ReviewDetailPresenterProtocol?
    
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

       //set the title of the navigation bar
        navigationItem.title = "Reviews"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Call the method
        getTheReviewDetail()
    }
}

private extension ReviewsViewController {
    func setup() {
        presenter = ReviewDetailPresenter(sourceVM: self)
    }
    
    func getTheReviewDetail() {
        presenter?.getDetailReview(with: idPost)
    }
}

extension ReviewsViewController: ReviewDetailViewModel {
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func showReviewDetail(title: String, body: String) {
        //Assign the data to the textView
       self.detailReviewTxt.text = body
       self.titleDetail.text = title
    }
    
    func showError(errorMessage: String) {
        showAlert(with: errorMessage)
    }
}
