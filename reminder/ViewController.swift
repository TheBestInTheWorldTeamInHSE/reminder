//
//  ViewController.swift
//  reminder
//
//  Created by Владислав Вечерковский on 12.07.2020.
//  Copyright © 2020 Владислав Вечерковский. All rights reserved.
//

import UIKit
import UserNotifications

extension UIView {
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }

    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    var counter = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button.layer.cornerRadius = button.height / 2
        
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    private func sendNotification(on time: Double) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "Text"
        
        let date = Date().addingTimeInterval(time)
        
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            // Check the error
        }
    }
    
    @IBAction func button(_ sender: UIButton) {
        if let time = Double(textField.text!) {
            print(time)
            sendNotification(on: time)
        } else {
            // User entered nothing.
        }
        
    }
    
    
}

