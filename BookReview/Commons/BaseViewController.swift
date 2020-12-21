//
//  BaseViewController.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Back"
    }
    
    
    internal func showAlert(with message: String){
        let alert = UIAlertController(title: "¡Aviso!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //mark-- Loader animated:
       func startAnimating() {
        let loadingTag = LoaderType.activity.hashValue
           let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
              
              var isShowing = false
              for subview:UIView in (rootViewController?.view.subviews)! {
                  if subview.tag == loadingTag{
                      isShowing = true
                  }
              }
              if !isShowing {
                  
                let loadingView = UIView().customActivityIndicator(view: rootViewController!.view, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), type: .activity)
                  loadingView.tag = loadingTag
                  rootViewController?.view.addSubview(loadingView)
       
              }
              
          }
          
          
       func stopAnimating() {
            let loadingTag = LoaderType.activity.hashValue
           let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
              for subview:UIView in (rootViewController?.view.subviews)! {
                  if subview.tag == loadingTag{
                      subview.removeFromSuperview()
                  }
              }
              
          }

}
