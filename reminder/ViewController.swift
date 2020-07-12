//
//  ViewController.swift
//  reminder
//
//  Created by Владислав Вечерковский on 12.07.2020.
//  Copyright © 2020 Владислав Вечерковский. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "Text"
        
        let date = Date().addingTimeInterval(10)
        
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (errpr) in
            // Check the error 
        }
    }
    

}

