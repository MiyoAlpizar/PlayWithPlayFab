//
//  LoginViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let keyBoardHelper = KeyBoardHelper()
    
    let viewmodel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hideKeyboardWhenTappedAround()
        setTargets()
        setNavtationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtEmail.becomeFirstResponder()
    }
    
    private func setNavtationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(close))
    }
    
    @objc private func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func setTargets() {
        keyBoardHelper.delegate = self
        self.loading.hide()
        btnCreateAccount.addTarget(self, action: #selector(goCreateAccount), for: UIControl.Event.touchUpInside)
        btnEnter.addTarget(self, action: #selector(goLogin), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func goCreateAccount(){
        let ca = UIStoryboard.main.instantiate(CreateAccountViewController.self)
        self.navigationController?.pushViewController(ca, animated: true)
        
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
        AppHelper.shared.setBool(type: UserStrings.isLoginAnonymously, value: false)
        if AppHelper.shared.getString(type: UserStrings.playFabID) != "" {
            let vc = UIStoryboard.main.instantiate(ViewController.self)
            UIWindow.key?.rootViewController = vc
        }
    }
}

extension LoginViewController: KeyBoardDelegate {
    func heightChanged(height: CGFloat, duration: TimeInterval, isUp: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.height - height)
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        }
    }
}
