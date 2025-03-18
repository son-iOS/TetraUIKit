//
//  CollectionOfViewsExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

#if os(iOS)

import UIKit

public extension Array where Element == UIView {
  /// Get the view with the specified [tag] within this array. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> UIView? {
    return first(where: { $0.tag == tag })
  }
}

public extension Set where Element == UIView {
  /// Get the view with the specified [tag] within this set. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> UIView? {
    return first(where: { $0.tag == tag })
  }
}

public extension Dictionary where Value == UIView {
  /// Get the view with the specified [tag] within this dictionary's values. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> UIView? {
    return values.first(where: { $0.tag == tag })
  }
}

#elseif os(macOS)

import AppKit

public extension Array where Element == NSView {
  /// Get the view with the specified [tag] within this array. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> NSView? {
    return first(where: { $0.tag == tag })
  }
}

public extension Set where Element == NSView {
  /// Get the view with the specified [tag] within this set. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> NSView? {
    return first(where: { $0.tag == tag })
  }
}

public extension Dictionary where Value == NSView {
  /// Get the view with the specified [tag] within this dictionary's values. This doesn't search recursively.
  @MainActor func viewWithTag(_ tag: Int) -> NSView? {
    return values.first(where: { $0.tag == tag })
  }
}

#endif
