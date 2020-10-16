//
//  ViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit
class ViewController: UIViewController, NotificationsDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsHelper.shared.delegate = self
        PlayFabHelper.shared.LoginUser { (result) in
            switch result {
            case .success(_):
                NotificationsHelper.shared.configPushNotifications()
                
            case .failure(_):
                break
            }
        }
    }
    
    func didSetNotification() {
        
    }
    
    func isNotificationsAvailable(available: Bool) {
        
    }
}

