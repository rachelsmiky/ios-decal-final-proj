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
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateView()
    }
    
    @IBAction func applyToAttend(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let user = appDelegate.currentUser {
            meeting?.addToParticipants(user)
            updateView()
        }
    }

    func updateView () {
        
        my_title.text = meeting?.title
        summary.text = meeting?.summary
        
        if let date = meeting?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM dd, yyy hh:mm a"
            timeLabel.text = dateFormatter.string(from: date)
        }
        
        var participants: Array<String> = []
        for user in (meeting?.participants as! Set<User>) {
            participants.append(user.name!)
        }
        
        members.text = participants.joined(separator: "\n")
    }
}
