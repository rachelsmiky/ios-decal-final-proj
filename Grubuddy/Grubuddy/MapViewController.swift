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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var fetchedResultController: NSFetchedResultsController<Meeting>? = nil
    var locationManager = CLLocationManager()
    var mapCentered = false
    var resultSearchController:UISearchController? = nil
    var searchResultPlacemark: MKAnnotation? = nil
    var meeting: Meeting? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        loadAnnotaions()
        loadSearchBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationAuthorizationStatus()
    }
    
    func loadSearchBar () {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        
        locationSearchTable.didSelectItem = { (item: MKPlacemark) -> () in
            self.removeSearchResult()
            self.insertSearchResult(item)
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMap(withLocation location:CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !mapCentered, let location = locations.last {
            centerMap(withLocation: location)
            mapCentered = true
        }
    }
        
    func loadAnnotaions () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let meetingRequest: NSFetchRequest<Meeting> = Meeting.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        meetingRequest.sortDescriptors = [sortDescriptor]
        
        // load existing meetings
        
        do {
            let fetchedMeetings = try context.fetch(meetingRequest)
            print(fetchedMeetings)
            mapView.addAnnotations(fetchedMeetings)
        } catch {
            fatalError("Failed to fetch meetings: \(error)")
        }
        
        // track for changes
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: meetingRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        do {
            try fetchedResultController?.performFetch()
        } catch {
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            
            var button: UIButton? = nil
            
            if annotation is Meeting {
                button = UIButton(type:.detailDisclosure)
            } else {
                button = UIButton(type:.contactAdd)
                view.pinTintColor = UIColor.green
            }
            
            view.rightCalloutAccessoryView = button
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotation = view.annotation {
            if annotation is Meeting {
                meeting = annotation as! Meeting
                performSegue(withIdentifier: "showDetail", sender: self)
                // TODO: push to new controller
                
                print("\(annotation) tapped, pushing to detail")
            } else {
                
                // TODO: push to new controller
                print("\(annotation) tapped, pushing to new meeting view")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! NewMeetingViewController
                nextViewController.annotation = annotation
                self.present(nextViewController, animated:true, completion:nil)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "showDetail" {
            let targetVC = segue.destination as! MeetingDetailViewController
            targetVC.meeting = meeting
        }
    }
    
    func insertSearchResult(_ item: MKPlacemark) {
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = item.coordinate
        annotaion.title = item.name
        annotaion.subtitle = item.title
        
        searchResultPlacemark = annotaion
        mapView.addAnnotation(annotaion)
        centerMap(withLocation: CLLocation.init(latitude: annotaion.coordinate.latitude, longitude: annotaion.coordinate.longitude))
        mapView.selectAnnotation(annotaion, animated: true)
    }
    
    func removeSearchResult() {
        if let searchResultPlacemark = searchResultPlacemark {
            mapView.removeAnnotation(searchResultPlacemark)
            self.searchResultPlacemark = nil
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // Only support insert for now
        if type == .insert {
            if let anObject = anObject as? MKAnnotation {
                mapView.addAnnotation(anObject)
            }
        }
    }
    
}

