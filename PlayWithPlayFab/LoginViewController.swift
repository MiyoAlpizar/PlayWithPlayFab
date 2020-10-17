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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.becomeFirstResponder()
    }
}
