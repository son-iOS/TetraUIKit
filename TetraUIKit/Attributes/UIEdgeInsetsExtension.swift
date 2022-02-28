//
//  UIEdgeInsetsExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    
    /// Create an insets with all edges set to the same value.
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: -value, right: -value)
    }
    
    /// Create an insets with symmetric edges set to the same value.
    static func symmetric(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
    
    /// Create an insets with different edges.
    static func only(top: CGFloat = 0,
                     bottom: CGFloat = 0,
                     left: CGFloat = 0,
                     right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: -bottom, right: -right)
    }
}
