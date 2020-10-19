//
//  CreateAccounViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 18/10/20.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPwd: UITextField!
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var btnCreateAccount: UIButton!
    
    let viewModel = CreateAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.becomeFirstResponder()
        loading.isHidden = true
        setNavtationBar()
        setTargets()
    }
    
    private func setTargets() {
        btnCreateAccount.addTarget(self, action: #selector(validateInfo), for: UIControl.Event.touchUpInside)
    }
    
    private func setNavtationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(close))
    }
    
    @objc private func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func validateInfo() {
        
        guard txtUserName.isLargerThan(minLenght: 3), let userName = txtUserName.text else {
            alert(message: "You must enter a valid User Name") { [weak self] in
                guard let `self` = self else { return }
                self.txtUserName.becomeFirstResponder()
            }
            return
        }
        
        guard txtName.isLargerThan(minLenght: 3), let name = txtName.text else {
            alert(message: "You must enter a valid name") { [weak self] in
                guard let `self` = self else { return }
                self.txtName.becomeFirstResponder()
            }
            return
        }
        
        guard let email = txtEmail.text else {
            alert(message: "You must enter a valid email") { [weak self] in
                guard let `self` = self else { return }
                self.txtEmail.becomeFirstResponder()
            }
            return
        }
        guard email.isValidEmail() else {
            alert(message: "You must enter a valid email") { [weak self] in
                guard let `self` = self else { return }
                self.txtEmail.becomeFirstResponder()
            }
            return
        }
        guard txtPwd.isLargerThan(minLenght: 5) else {
            alert(message: "Password must be at least 6 characters long") { [weak self] in
                guard let `self` = self else { return }
                self.txtPwd.becomeFirstResponder()
            }
            return
        }
        
        self.view.isUserInteractionEnabled = false
        loading.startAnimating()
        loading.isHidden = false
        viewModel.createAccount(name: name, userName: userName, email: email, pwd: txtPwd.text!) { [weak self] (result) in
            guard let `self` = self else { return }
            self.view.isUserInteractionEnabled = true
            self.loading.stopAnimating()
            self.loading.isHidden = true
            switch result {
            case .success(_):
                self.goMain()
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
