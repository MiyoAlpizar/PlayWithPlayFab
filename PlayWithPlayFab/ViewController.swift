//
//  ViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let login_request = ClientLoginWithCustomIDRequest()
        var uuid: String = "no_uuid"
        if let id = UIDevice.current.identifierForVendor?.uuidString {
            uuid = id
        }
        login_request.customId = uuid
        login_request.createAccount = true
        login_request.titleId = "62E19"
        let api = PlayFabClientAPI()
        api.login(withCustomID: login_request, success: { (result, userData) in
            guard let result = result else {
                print("No result")
                return
            }
            print(result)
            print(result.entityToken ?? "No Token")
        }, failure: { (error, userData) in
            print(error?.description ??  "No error")
        }, withUserData: nil)
        
    }


}

