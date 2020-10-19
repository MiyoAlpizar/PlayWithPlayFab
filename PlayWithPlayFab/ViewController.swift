//
//  ViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit
class ViewController: UIViewController, NotificationsDelegate {
    
    @IBOutlet var lblPlayFab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsHelper.shared.delegate = self
        NotificationsHelper.shared.configPushNotifications()
        lblPlayFab.text = "PlayFab ID: " + AppHelper.shared.getString(type: UserStrings.playFabID)
    }
    
    func didSetNotification() {
        
    }
    
    func isNotificationsAvailable(available: Bool) {
        
    }
}

