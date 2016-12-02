//
//  MeetingDetailViewController.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/29/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import UIKit

class MeetingDetailViewController: UIViewController {

    var meeting: Meeting?
    @IBOutlet weak var my_title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var members: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func applyToAttend(_ sender: AnyObject) {
    
    }

    func updateView () {
        
        // TODO: update labels
        
    }
}
