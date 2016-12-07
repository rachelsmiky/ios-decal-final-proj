//
//  AppDelegate.swift
//  Grubuddy
//
//  Created by Kelvin Hong on 11/28/16.
//  Copyright © 2016 Grubuddy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentUser: User? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        preloadData()
        testFetching()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Grubuddy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func preloadData () {
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "preloaded") {
            return;
        } else {
            let context = persistentContainer.viewContext
            let meeting1 = NSEntityDescription.insertNewObject(forEntityName: "Meeting", into: context)
            meeting1.setValue("iOS Decal", forKey: "title")
            meeting1.setValue(37.875827, forKey: "latitude")
            meeting1.setValue(-122.258803, forKey: "longitude")
            meeting1.setValue(Date(), forKey: "date")
            let participants = meeting1.mutableSetValue(forKey: "participants")
            for name in ["Kelvin", "Erica", "Van", "Rachel"] {
                let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                user.setValue(name, forKey: "name")
                participants.add(user)
            }
            self.saveContext()
            userDefaults.set(true, forKey: "preloaded")
        }
        
    }
    
    func testFetching () {
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let fetchedUsers = try persistentContainer.viewContext.fetch(userRequest)
            print(fetchedUsers)
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
        
        let meetingRequest: NSFetchRequest<Meeting> = Meeting.fetchRequest()
        do {
            let fetchedMeetings = try persistentContainer.viewContext.fetch(meetingRequest)
            print(fetchedMeetings)
        } catch {
            fatalError("Failed to fetch meetings: \(error)")
        }
    }
}

