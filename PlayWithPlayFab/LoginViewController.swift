//
//  LoginViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPwd: UITextField!
    @IBOutlet var btnEnter: UIButton!
    @IBOutlet var btnCreateAccount: UIButton!
    @IBOutlet var loading: UIActivityIndicatorView!
    
    let viewmodel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.becomeFirstResponder()
        setTargets()
    }
    
    private func setTargets() {
        self.loading.hide()
        btnCreateAccount.addTarget(self, action: #selector(goCreateAccount), for: UIControl.Event.touchUpInside)
        btnEnter.addTarget(self, action: #selector(goLogin), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func goCreateAccount(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "CreateAccountViewController") as? CreateAccountViewController {
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            self.present(nc, animated: true, completion: nil)
        }
    }
    
    @objc private func goLogin() {
        guard let email = txtEmail.text else {
            alert(message: "You must enter a valid email") { [weak self] in
                self?.txtEmail.becomeFirstResponder()
            }
            return
        }
        
        guard email.isValidEmail() else {
            alert(message: "You must enter a valid email") { [weak self] in
                self?.txtEmail.becomeFirstResponder()
            }
            return
        }
        
        guard let pwd = txtPwd.text else {
            alert(message: "You must enter a valid password") { [weak self] in
                self?.txtPwd.becomeFirstResponder()
            }
            return
        }
        self.loading.show()
        self.view.isUserInteractionEnabled = false
        viewmodel.Login(email: email, pwd: pwd) { [weak self] (result) in
            guard let `self` = self else { return }
            self.view.isUserInteractionEnabled = true
            self.loading.hide()
            switch result {
            case .success(let ok):
                if ok {
                    self.goMain()
                }
            case .failure(let error):
                self.alert(message: error.localizedDescription)
            }
        }
    }
    
    private func goMain() {
        if AppHelper.shared.getString(type: UserStrings.playFabID) != "" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(identifier: "ViewController") as? ViewController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
}
