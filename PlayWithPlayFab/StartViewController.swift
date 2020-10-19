//
//  StartViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit

class StartViewController: UIViewController {
    
    private var indexColor: Int = 1
    private var loops: Int = 0
    private var isRegistered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
        validateIfRegistered()
    }
    
    private func validateIfRegistered() {
        if AppHelper.shared.getString(type: UserStrings.playFabID) != "" {
            isRegistered = true
        }
    }
    
    private func animateBackground() {
        let colors = Vars.main_colors
        UIView.animate(withDuration: 0.8, animations: { [weak self] in
            guard let `self` = self else { return }
            self.view.backgroundColor = colors[self.indexColor]
        }) { [weak self ](_) in
            guard let `self` = self else { return }
            self.indexColor += 1
            self.loops += 1
            if self.indexColor >= colors.count {
                self.indexColor = 0
            }
            if self.loops > 5 {
                self.goMain()
            }else if self.loops > 0 && !self.isRegistered {
                self.goLogin()
            }
            else {
                self.animateBackground()
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
    
    private func goLogin() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
}
