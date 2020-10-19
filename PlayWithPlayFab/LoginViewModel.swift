//
//  LoginViewModel.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 19/10/20.
//

import Foundation

class LoginViewModel {
    
    public func Login(email: String, pwd: String, done: @escaping(Result<Bool, Error>) -> Void) {
        PlayFabHelper.shared.LoginWithEmailAndPassword(email: email, pwd: pwd) { (result) in
            switch result {
            case .success(let ok):
                done(.success(ok))
            case .failure(let error):
                done(.failure(error))
            }
        }
    }
    
}
