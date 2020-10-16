//
//  PlayFabHelper.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import Foundation
import UIKit

class PlayFabHelper {
    
    private static var _shared = PlayFabHelper()
    
    public static var shared: PlayFabHelper {
        get {
            return _shared
        }
    }
    
    public func LoginUser(completion: @escaping(Result<ClientLoginResult, Error>) -> Void) {
        let login_request = ClientLoginWithCustomIDRequest()
        var uuid: String = "no_uuid"
        if let id = UIDevice.current.identifierForVendor?.uuidString {
            uuid = id
        }
        login_request.customId = uuid
        login_request.createAccount = true
        let api = PlayFabClientAPI()
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
    
}
