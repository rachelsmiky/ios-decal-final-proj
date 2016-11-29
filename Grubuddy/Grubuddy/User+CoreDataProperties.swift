//
//  User+CoreDataProperties.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/29/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import Foundation
import CoreData
//import 

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var meetings: NSSet?

}

// MARK: Generated accessors for meetings
extension User {

    @objc(addMeetingsObject:)
    @NSManaged public func addToMeetings(_ value: Meeting)

    @objc(removeMeetingsObject:)
    @NSManaged public func removeFromMeetings(_ value: Meeting)

    @objc(addMeetings:)
    @NSManaged public func addToMeetings(_ values: NSSet)

    @objc(removeMeetings:)
    @NSManaged public func removeFromMeetings(_ values: NSSet)

}
