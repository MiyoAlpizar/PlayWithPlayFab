//
//  StoryboardExtensions.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 17/10/20.
//

import Foundation
import UIKit

extension UIStoryboard {
    public static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    public func instantiate<A: UIViewController>(_ type: A.Type, withIdentifier identifier: String? = nil) -> A {
            let id = identifier ?? String(describing: type.self)
            guard let vc = self.instantiateViewController(withIdentifier: id) as? A else {
                fatalError("Could not instantiate view controller \(A.self)") }
            return vc
        }
}
