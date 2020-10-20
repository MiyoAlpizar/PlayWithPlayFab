//
//  LoginModeViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 20/10/20.
//

import UIKit

class LoginModeViewController: UIViewController {

    @IBOutlet weak var LoginAnonymouslyBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var CreateAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func LoginAnonymously(_ sender: Any) {
        PlayFabHelper.shared.LoginAnonymousUser { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let ok):
                AppHelper.shared.setString(type: UserStrings.playFabID, value: ok.playFabId)
                self.goMain()
            case .failure(let error):
                self.alert(message: error.localizedDescription)
            }
        }
    }
    
    private func goMain() {
        if AppHelper.shared.getString(type: UserStrings.playFabID) != "" {
            let vc = UIStoryboard.main.instantiate(ViewController.self)
            UIWindow.key?.rootViewController = vc
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        let vc = UIStoryboard.main.instantiate(LoginViewController.self)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
    
    @IBAction func CreateAccount(_ sender: Any) {
        let vc = UIStoryboard.main.instantiate(CreateAccountViewController.self)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
}
