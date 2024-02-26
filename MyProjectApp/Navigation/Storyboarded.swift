//
//  Storyboarded.swift
//  MyProjectApp
//
//  Created by admin on 26/02/2024.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension UIViewController: Storyboarded {}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
