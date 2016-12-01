//
//  Meeting+CoreDataClass.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/29/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import Foundation
import CoreData
import MapKit

public class Meeting: NSManagedObject, MKAnnotation {

    public var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(self.latitude, self.longitude)
        }
    }
    
}
