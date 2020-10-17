//
//  StoryboardExtensions.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 17/10/20.
//

import Foundation
import UIKit

protocol Storyboardable: class {
    static var storyboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return String(describing: self)
    }

    static func storyboardViewController<T: UIViewController>() -> T where T: Storyboardable {
        let storyboard = UIStoryboard(name: T.storyboardName, bundle: nil)

        guard let vc = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Could not instantiate initial storyboard with name: \(T.storyboardName)")
        }

        return vc
    }
}

extension UIViewController: Storyboardable { }