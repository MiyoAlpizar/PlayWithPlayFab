//
//  UIViewExtensions.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 19/10/20.
//

import Foundation
import UIKit

extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension UIActivityIndicatorView {
    func show() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func hide() {
        self.isHidden = true
        self.stopAnimating()
    }
}
