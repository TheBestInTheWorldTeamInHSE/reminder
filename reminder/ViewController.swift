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
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button.layer.cornerRadius = button.height / 2
        
        createDatePicker()
        
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        textField.text = formatter.string(from: datePicker.date)
        textField.textAlignment = .center
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func button(_ sender: UIButton) {
        
        let time = datePicker.date.timeIntervalSinceNow
        print(time)
        
        sendNotification(on: time)
        
    }
    
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
    
    
}

