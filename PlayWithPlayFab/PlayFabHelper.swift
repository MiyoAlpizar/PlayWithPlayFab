//
//  PlayFabHelper.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import Foundation
import UIKit

protocol PlayFabDelegate: class {
    func onUserInfoChanged(info: ClientUserAccountInfo)
}

class PlayFabHelper {
    private let api = PlayFabClientAPI()
    private static var _shared = PlayFabHelper()
    public weak var delegate: PlayFabDelegate?
    
    public static var shared: PlayFabHelper {
        get {
            return _shared
        }
    }
    
    /// Login annonymous user with vendor ID
    /// This is the best way to login an user, according to PlayFabs docs
    public func LoginAnonymousUser(completion: @escaping(Result<ClientLoginResult, Error>) -> Void) {
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
            print("LoggeIn Annonymously....")
            completion(.success(result))
            
        }, failure: { (error, userData) in
            if let error = error {
                completion(.failure(NSError(domain: error.errorMessage, code: 100, userInfo: nil)))
            }else {
                completion(.failure(NSError(domain: "No error message found", code: 100, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    /// Adds user name, email and password to user loggedin annonymoulsy
    /// If user wants to have the chance to recovery their accounts, they have to add Emai, userName and password to their current anonnymous account
    public func AddUserAndPassword(email: String,userName: String, password: String, done: @escaping(Result<String, Error>) -> Void) {
        let request = ClientAddUsernamePasswordRequest()
        request.email = email
        request.username = userName
        request.password = password
        
        
        api.addUsernamePassword(request, success: { (result, obj) in
            if let result = result {
                done(.success(result.username))
                self.GetUserInfo { (result) in
                    
                }
            }
        }, failure: { (error, obj) in
            if let error = error {
                done(.failure(NSError(domain: error.error, code: error.code as! Int, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    
    /// Gets the info of the current user
    public func GetUserInfo(done: @escaping(Result<ClientUserAccountInfo, Error>) -> Void) {
        let request = ClientGetAccountInfoRequest()
        api.getAccountInfo(request, success: { (result, obj) in
            if let result = result {
                done(.success(result.accountInfo))
                if let delegate = self.delegate {
                    delegate.onUserInfoChanged(info: result.accountInfo)
                }
            }
        }, failure: { (error, obj) in
            if let error = error {
                done(.failure(NSError(domain: error.error, code: error.code as! Int, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    /// Gets If User Has or Has Not Saved their User Name, Email And Password
    public func UserHasUserNameAndPassword(done: @escaping(Bool) -> Void) {
        GetUserInfo { (result) in
            switch result {
            case .success(let userInfo):
                print(userInfo.playFabId ?? "No PlayFab Id")
                done(userInfo.username != nil)
            case .failure(let error):
                print(error.localizedDescription)
                done(false)
            }
        }
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
    
    /// Login Into PlayFab With Credentials
    public func LoginWithEmailAndPassword(email: String, pwd: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        
        let request = ClientLoginWithEmailAddressRequest()
        request.email = email
        request.password = pwd
        api.login(withEmailAddress: request, success: { (result, obj) in
            if let result = result {
                completion(.success(true))
                AppHelper.shared.setString(type: UserStrings.playFabID, value: result.playFabId)
            }else {
                completion(.failure(NSError(domain: "No results found", code: 50, userInfo: nil)))
            }
        }, failure: { (error, obj) in
            if let error = error {
                completion(.failure(NSError(domain: error.error, code: error.code as! Int, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    /// Registers User And The Make the Login
    public func RegisterUser(userName: String, name: String,email: String, pwd: String, completion: @escaping(Result<String, Error>) -> Void) {
        let request = ClientRegisterPlayFabUserRequest()
        request.username = userName
        request.email = email
        request.password = pwd
        request.displayName = name
        request.titleId = "62E19"
         api.registerPlayFabUser(request, success: { (result, obj) in
            guard let result = result else {
                completion(.failure(NSError(domain: "Error empty result", code: 100, userInfo: nil)))
                return
            }
            self.LoginWithEmailAndPassword(email: email, pwd: pwd) { (res) in
                switch res {
                case .success(let isIn):
                    if isIn {
                        completion(.success(result.playFabId))
                    }else {
                        completion(.failure(NSError(domain: "Registered but not Logged In", code: 50, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }, failure: { (error, obj) in
            if let error = error {
                completion(.failure(NSError(domain: error.errorMessage, code: 100, userInfo: nil)))
            }
        }, withUserData: nil)
    }
    
    /// Login with User
    public func LoginWithUserAndPassword(user: String,pwd: String, completion: @escaping(Bool) -> Void) {
        let request = ClientLoginWithPlayFabRequest()
        request.username = user
        request.password = pwd
        api.login(withPlayFab: request, success: { (result, obj) in
            if let result = result {
                completion(true)
                AppHelper.shared.setString(type: UserStrings.playFabID, value: result.playFabId)
            }else {
                completion(false)
            }
        }, failure: { (error, obj) in
            
        }, withUserData: nil)
    }
    
    
}
