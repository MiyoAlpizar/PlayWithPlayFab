//
//  StartViewController.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import UIKit

class StartViewController: UIViewController {
    
    private var indexColor: Int = 0
    private var loops: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
    }
    
    private func animateBackground() {
        let colors = Vars.main_colors
        UIView.animate(withDuration: 1.8, animations: { [weak self] in
            guard let `self` = self else { return }
            self.view.backgroundColor = colors[self.indexColor]
        }) { [weak self ](_) in
            guard let `self` = self else { return }
            self.indexColor += 1
            self.loops += 1
            if self.indexColor >= colors.count {
                self.indexColor = 0
            }
            if self.loops > 4 {
                //self.goMain()
            }else {
                self.animateBackground()
            }
        }
    }
}
