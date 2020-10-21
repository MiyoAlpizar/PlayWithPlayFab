//
//  ViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit
class ViewController: UIViewController, NotificationsDelegate {
    
    @IBOutlet weak var lblPlayFab: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var btnAddEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationsHelper.shared.delegate = self
        NotificationsHelper.shared.configPushNotifications()
        lblPlayFab.text = "PlayFab ID: " + AppHelper.shared.getString(type: UserStrings.playFabID)
        PlayFabHelper.shared.UserHasUserNameAndPassword { (has) in
            print("Has " + has.description)
        }
        loadUserInfo()
    }
    
    func didSetNotification() {
        
    }
    
    func isNotificationsAvailable(available: Bool) {
        
    }
    
    func loadUserInfo() {
        self.btnAddEmail.isHidden = false
        PlayFabHelper.shared.GetUserInfo { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let info):
                if let email = info.privateInfo.email {
                    self.lblDisplayName.text = "Email: " + email
                }
                if let user = info.username {
                    self.lblUserName.text = "User: " + user
                }else {
                    self.btnAddEmail.isHidden = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func AddEmail(_ sender: Any) {
        let ca = UIStoryboard.main.instantiate(CreateAccountViewController.self)
        ca.isAddEmail = true
        let nc = UINavigationController(rootViewController: ca)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
}

extension ViewController: PlayFabDelegate {
    func onUserInfoChanged(info: ClientUserAccountInfo) {
        if let email = info.privateInfo.email {
            self.lblDisplayName.text = "Email: " + email
        }
        if let user = info.username {
            self.lblUserName.text = "User: " + user
            self.btnAddEmail.isHidden = true
        }else {
            self.btnAddEmail.isHidden = false
        }
    }
}

