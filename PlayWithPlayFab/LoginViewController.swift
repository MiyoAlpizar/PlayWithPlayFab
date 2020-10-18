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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.becomeFirstResponder()
        setTargets()
    }
    
    private func setTargets() {
        btnCreateAccount.addTarget(self, action: #selector(goCreateAccount), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func goCreateAccount(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "CreateAccountViewController") as? CreateAccountViewController {
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            self.present(nc, animated: true, completion: nil)
        }
    }
}
