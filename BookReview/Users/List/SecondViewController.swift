//
//  SecondViewController.swift
//  BookReview
//
//  Created by Angel Casado on 2/1/16.
//  Copyright © 2016 Televisa. All rights reserved.
//

import UIKit

protocol UsersViewModel: BaseViewModel {
    func showUsers(userData : [UsersData])
    func showError(errorMessage: String)
}

class SecondViewController: BaseViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var userData : [UsersData] = [UsersData]()
    private var presenter: UserListPresenterLogic?
    
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
        //Call the function
        navigationItem.title = "Users"
        getTheUsers()
        
    }

}

private extension SecondViewController {
    func setup() {
        presenter = UserListPresenter(with: self)
    }
    
    func getTheUsers() {
        presenter?.getTheUsers()
    }
}

extension SecondViewController: UsersViewModel {
    func showLoader() {
        startAnimating()
    }
    
    func hideLoader() {
        stopAnimating()
    }
    
    func showUsers(userData : [UsersData]) {
        self.userData = userData
        self.tableView.reloadData()
    }
    
    func showError(errorMessage: String) {
        showAlert(with: errorMessage)
    }
}

//MARK:- TableView Protocols
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserNameTableViewCell.identifier, for: indexPath as IndexPath) as! UserNameTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        cell.userName.text = userData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem  = userData[indexPath.row]
        presenter?.showUserDetail(with: selectedItem.id, and: selectedItem.name)
    }
    
    //Set the row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79.0
    }
}

