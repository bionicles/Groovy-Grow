//
//  FacebookLoginViewController.swift
//  Groovy Grow
//
//  Created by Sarah Drake on 3/22/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class FacebookLoginViewController: UIViewController {
    
    weak var delegate: CancelButtonDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        print("cancel button works")
        delegate?.cancelButtonPressed(by: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16,  y: 50,  width: view.frame.width - 32, height: 50)
    }
    
    
    
}
