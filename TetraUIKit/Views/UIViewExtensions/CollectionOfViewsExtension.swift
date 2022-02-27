//
//  CollectionOfViewsExtension.swift
//  DeclarativeUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import Foundation
import UIKit

public extension Array where Element == UIView {
    /// Get the view with the specified [tag] within this array. This doesn't search recursively.
    func viewWithTag(_ tag: Int) -> UIView? {
        return first(where: { $0.tag == tag })
    }
}

public extension Set where Element == UIView {
    /// Get the view with the specified [tag] within this set. This doesn't search recursively.
    func viewWithTag(_ tag: Int) -> UIView? {
        return first(where: { $0.tag == tag })
    }
}

public extension Dictionary where Value == UIView {
    /// Get the view with the specified [tag] within this dictionary's values. This doesn't search recursively.
    func viewWithTag(_ tag: Int) -> UIView? {
        return values.first(where: { $0.tag == tag })
    }
}
