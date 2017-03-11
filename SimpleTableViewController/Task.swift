//
//  Task.swift
//  SimpleTableViewController
//
//  Created by Pooja Tyagi on 08/03/17.
//  Copyright © 2017 Pooja Tyagi. All rights reserved.
//

import UIKit


class Task : NSObject, NSCoding{
    // MARK: - Properties
    var title: String
    var detail: String
    var time: Date
    var notification: UILocalNotification
    
     // MARK: - Archive Paths to store data
    static let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = documentDirectory.appendingPathComponent("reminders")
    
    
    
     // MARK: PropertyKeys
    struct PropertyKey {
        static let title = "title"
        static let detail = "detail"
        static let notification = "notification"
        static let time = "time"
    }
    
    //MARK: Initialization
    init?(title: String, detail: String,time: Date,notification: UILocalNotification) {
        self.title = title
        self.detail = detail
        self.notification = notification
        self.time = time
        super.init()
    }
    
    // MARK: - Deinitializer
    
    deinit{
    // to cancel the notification already fired
    UIApplication.shared.cancelLocalNotification(self.notification)
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(detail, forKey: PropertyKey.detail)
        aCoder.encode(notification, forKey: PropertyKey.notification)
        aCoder.encode(time,forKey: PropertyKey.time)
    }
    

    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title)  else {
            return nil
        }
        let detail = aDecoder.decodeObject(forKey: PropertyKey.detail)
        
        let time = aDecoder.decodeObject(forKey: PropertyKey.time)
        
        let notification = aDecoder.decodeObject(forKey: PropertyKey.notification)
        // Must call designated initializer.
        self.init(title: title as! String, detail: detail! as! String, time: time as! Date,notification:notification as! UILocalNotification)
        
    }
    


}
