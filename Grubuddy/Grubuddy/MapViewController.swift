//
//  ViewController.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/28/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var my_title: UILabel!
    @IBOutlet weak var members: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        loadAnnotaions()
    }

    func loadAnnotaions () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let meetingRequest: NSFetchRequest<Meeting> = Meeting.fetchRequest()
        do {
            let fetchedMeetings = try context.fetch(meetingRequest)
            print(fetchedMeetings)
            mapView.addAnnotations(fetchedMeetings)
        } catch {
            fatalError("Failed to fetch meetings: \(error)")
        }
    }

    func updateOverlay(meeting: Meeting) {
        
        // TODO: update labels
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

