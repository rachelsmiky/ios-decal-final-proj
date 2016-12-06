//
//  LoginViewController.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/29/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func login(withUsername username: String, password: String) {
        if username.characters.count > 0 && password.characters.count > 0 {
            
            // TODO: 1. create a NSFetchRequest
            //       2. Add a predicate to the fetch request
            //       3. if no matched user is found, create a new one, using NSEntityDescription.insertNewObject
            //       4. store user in AppDelegate
            
            dismiss(animated: true, completion: nil)
        }
    }

}
