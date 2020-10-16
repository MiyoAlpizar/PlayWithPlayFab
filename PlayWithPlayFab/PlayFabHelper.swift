//
//  PlayFabHelper.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import Foundation
import UIKit

class PlayFabHelper {
    private let api = PlayFabClientAPI()
    private static var _shared = PlayFabHelper()
    
    public static var shared: PlayFabHelper {
        get {
            return _shared
        }
    }
    
    /// Login User into PlayFab server, in order to register for push notifications
    public func LoginUser(completion: @escaping(Result<ClientLoginResult, Error>) -> Void) {
        let login_request = ClientLoginWithCustomIDRequest()
        var uuid: String = "no_uuid"
        if let id = UIDevice.current.identifierForVendor?.uuidString {
            uuid = id
        }
        login_request.customId = uuid
        login_request.createAccount = true
        
        api.login(withCustomID: login_request, success: { (result, userData) in
            guard let result = result else {
                completion(.failure(NSError(domain: "No results found", code: 100, userInfo: nil)))
                return
            }
            completion(.success(result))
            
        }, failure: { (error, userData) in
            if let error = error {
                completion(.failure(NSError(domain: error.errorMessage, code: 100, userInfo: nil)))
            }else {
                completion(.failure(NSError(domain: "No error message found", code: 100, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    /// Registers the user to receive push notifications, and saves the token in User Settings
    public func Register(token: String) {
        let request = ClientRegisterForIOSPushNotificationRequest()
        request.confirmationMessage = "Welcome to this awesome App"
        request.deviceToken = token
        request.sendPushNotificationConfirmation = true
        
        api.register(forIOSPushNotification: request, success: { (result, obj) in
            if let result = result {
                AppHelper.shared.setString(type: UserStrings.token, value: token)
                print(result)
            }
        }, failure: { (error, obj) in
            if let error = error {
                print(error.errorMessage ?? "No error found")
            }
        }, withUserData: nil)
    }
    
}
