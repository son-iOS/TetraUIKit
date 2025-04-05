//
//  UIEdgeInsetsExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

#if os(iOS)

import UIKit

public extension UIEdgeInsets {

  /// Create an insets with all edges set to the same value.
  static func all(_ value: Double) -> UIEdgeInsets {
    return UIEdgeInsets(top: value, left: value, bottom: -value, right: -value)
  }

  /// Create an insets with symmetric edges set to the same value.
  static func symmetric(horizontal: Double = 0, vertical: Double = 0) -> UIEdgeInsets {
    return UIEdgeInsets(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
  }

  /// Create an insets with different edges.
  static func only(
    top: Double = 0,
    bottom: Double = 0,
    left: Double = 0,
    right: Double = 0
  ) -> UIEdgeInsets {
    return UIEdgeInsets(top: top, left: left, bottom: -bottom, right: -right)
  }
}

#elseif os(macOS)

import AppKit

public extension NSEdgeInsets {

  static var zero: NSEdgeInsets { NSEdgeInsetsZero }

  /// Create an insets with all edges set to the same value.
  static func all(_ value: Double) -> NSEdgeInsets {
    return NSEdgeInsets(top: value, left: value, bottom: -value, right: -value)
  }

  /// Create an insets with symmetric edges set to the same value.
  static func symmetric(horizontal: Double = 0, vertical: Double = 0) -> NSEdgeInsets {
    return NSEdgeInsets(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
  }

  /// Create an insets with different edges.
  static func only(
    top: Double = 0,
    bottom: Double = 0,
    left: Double = 0,
    right: Double = 0
  ) -> NSEdgeInsets {
    return NSEdgeInsets(top: top, left: left, bottom: -bottom, right: -right)
  }
}

#endif
