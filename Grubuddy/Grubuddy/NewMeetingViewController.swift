//
//  NewMeetingViewController.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 12/3/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class NewMeetingViewController: UIViewController {

    var annotation: MKAnnotation? = nil
    
    @IBOutlet weak var meetingTime: UIDatePicker!
    
    @IBOutlet weak var meetingTitle: UITextField!
    
    @IBOutlet weak var meetingSummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: initialize labels using the given annotation
        
    }

    @IBAction func submit(_ sender: AnyObject) {
        createMeeting(withTitle: meetingTitle.text!, summary: meetingSummary.text!, date: meetingTime.date,coordinate: annotation!.coordinate)
        
        
        dismiss(animated: true, completion: nil)
    }
    func createMeeting(withTitle title: String, summary: String?, date: Date?, coordinate: CLLocationCoordinate2D) {
        
        // TODO: insert entity into core data
    }
    
}
