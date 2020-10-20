//
//  StartViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    private var indexColor: Int = 1
    private var loops: Int = 0
    private var isRegistered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAll()
        animateBackground()
        validateIfRegistered()
        //loginAnonnymously()
    }
    
    private func validateIfRegistered() {
        if AppHelper.shared.getString(type: UserStrings.playFabID) != "" {
            isRegistered = false
        }
    }
    
    private func initAll() {
        lblTitle.font = UIFont(name: "Menlo", size: 45)
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
            }else if self.loops > 3 && !self.isRegistered {
                self.goChooseLogin()
            }
            else {
                self.animateBackground()
            }
        }
    }
    
    private func loginAnonnymously() {
        PlayFabHelper.shared.LoginAnonymousUser { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let ok):
                AppHelper.shared.setString(type: UserStrings.playFabID, value: ok.playFabId)
                self.isRegistered = true
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
    
    private func goChooseLogin() {
        let vc = UIStoryboard.main.instantiate(LoginModeViewController.self)
        UIWindow.key?.rootViewController = vc
    }
}
