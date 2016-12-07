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

class NewMeetingViewController: UITableViewController {

    var annotation: MKAnnotation? = nil
    
    @IBOutlet weak var meetingTime: UIDatePicker!
    
    @IBOutlet weak var meetingTitle: UITextField!
    
    @IBOutlet weak var meetingSummary: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: initialize labels using the given annotation
        
    }

    @IBAction func submit(_ sender: AnyObject) {
        createMeeting(withTitle: meetingTitle.text!,
                      summary: meetingSummary.text!,
                      date: meetingTime.date,
                      coordinate: annotation!.coordinate)
        
        self.navigationController?.popViewController(animated: true)
    }
    func createMeeting(withTitle title: String, summary: String?, date: Date?, coordinate: CLLocationCoordinate2D) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let meeting = NSEntityDescription.insertNewObject(forEntityName: "Meeting", into: context)
        meeting.setValue(title, forKey: "title")
        meeting.setValue(summary, forKey: "summary")
        meeting.setValue(date, forKey: "date")
        meeting.setValue(coordinate.latitude, forKey: "latitude")
        meeting.setValue(coordinate.longitude, forKey: "longitude")
        let participants = meeting.mutableSetValue(forKey: "participants")
        participants.add(appDelegate.currentUser!)
        
        appDelegate.saveContext()
    }
    
}
