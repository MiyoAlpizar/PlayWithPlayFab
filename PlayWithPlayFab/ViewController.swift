//
//  ViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit
class ViewController: UIViewController, NotificationsDelegate {
    
    @IBOutlet weak var lblPlayFab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsHelper.shared.delegate = self
        NotificationsHelper.shared.configPushNotifications()
        lblPlayFab.text = "PlayFab ID: " + AppHelper.shared.getString(type: UserStrings.playFabID)
        PlayFabHelper.shared.UserHasUserNameAndPassword { (has) in
            print("Has " + has.description)
        }
    }
    
    func didSetNotification() {
        
    }
    
    func isNotificationsAvailable(available: Bool) {
        
    }
}

