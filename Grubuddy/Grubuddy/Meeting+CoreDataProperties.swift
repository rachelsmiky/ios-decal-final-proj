//
//  Meeting+CoreDataProperties.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/29/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import Foundation
import CoreData
//import 

extension Meeting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meeting> {
        return NSFetchRequest<Meeting>(entityName: "Meeting");
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var summary: String?
    @NSManaged public var participants: NSSet?

}

// MARK: Generated accessors for participants
extension Meeting {

    @objc(addParticipantsObject:)
    @NSManaged public func addToParticipants(_ value: User)

    @objc(removeParticipantsObject:)
    @NSManaged public func removeFromParticipants(_ value: User)

    @objc(addParticipants:)
    @NSManaged public func addToParticipants(_ values: NSSet)

    @objc(removeParticipants:)
    @NSManaged public func removeFromParticipants(_ values: NSSet)

}
