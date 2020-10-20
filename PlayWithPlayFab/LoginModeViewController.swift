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
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.hide()
    }
    
    
    @IBAction func LoginAnonymously(_ sender: Any) {
        activity.show()
        self.view.isUserInteractionEnabled = false
        PlayFabHelper.shared.LoginAnonymousUser { [weak self] (result) in
            guard let `self` = self else { return }
            self.activity.hide()
            self.view.isUserInteractionEnabled = true
            switch result {
            case .success(let ok):
                AppHelper.shared.setString(type: UserStrings.playFabID, value: ok.playFabId)
                AppHelper.shared.setBool(type: UserStrings.isLoginAnonymously, value: true)
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
