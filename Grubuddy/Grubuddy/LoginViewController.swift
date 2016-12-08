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
        login(withUsername: username.text!, password: password.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func login(withUsername username: String, password: String) {
        if username.characters.count > 0 && password.characters.count > 0 {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let userRequest: NSFetchRequest<User> = User.fetchRequest()
            let userPredicate: NSPredicate = NSPredicate(format: "name == %@", username)
            userRequest.predicate = userPredicate
            
            do {
                let fetchedUsers = try context.fetch(userRequest)
                print(fetchedUsers)
                if fetchedUsers == [] {
                    let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                    user.setValue(username, forKey: "name")
                    appDelegate.currentUser = user as! User
                    appDelegate.saveContext()
                } else {
                    appDelegate.currentUser = fetchedUsers[0]
                }
            } catch {
                fatalError("Failed to fetch users: \(error)")
            }
            dismiss(animated: true, completion: nil)
        }
    }

}
