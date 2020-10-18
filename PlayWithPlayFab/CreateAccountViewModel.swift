//
//  CreateAccountViewModel.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 18/10/20.
//

import Foundation

class CreateAccountViewModel {
    
    public func createAccount(name: String, userName: String, email: String, pwd: String, done: @escaping(Result<Bool, Error>) -> Void) {
        PlayFabHelper.shared.RegisterUser(userName: userName, name: name, email: email, pwd: pwd) { (result) in
            switch result {
            case .success(let playFabID):
                AppHelper.shared.setString(type: UserStrings.playFabID, value: playFabID)
                done(.success(true))
            case .failure(let error):
                done(.failure(error))
            }
        }
    }
    
}
