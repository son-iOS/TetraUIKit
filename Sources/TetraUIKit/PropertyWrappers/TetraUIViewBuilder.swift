//
//  TetraUIViewBuilder.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

#if os(iOS)

import UIKit

/// Result builder implementation for `UIView`.
/// - This is pretty the same as `ViewBuilder` from `SwiftUI`
@resultBuilder
public struct TetraUIViewBuilder {
  public static func buildBlock(_ components: [UIView]...) -> [UIView] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ component: UIView?) -> [UIView] {
    if let component = component {
      return [component]
    } else {
      return []
    }
  }

  public static func buildExpression(_ components: [UIView]...) -> [UIView] {
    components.flatMap { $0 }
  }

  public static func buildIf(_ components: [UIView]?...) -> [UIView] {
    components.compactMap { $0 }.flatMap { $0 }
  }

  public static func buildEither(first: [UIView]) -> [UIView] {
    first
  }

  public static func buildEither(second: [UIView]) -> [UIView] {
    second
  }

  public static func buildArray(_ components: [[UIView]]) -> [UIView] {
    components.flatMap({ $0 })
  }

  public static func buildOptional(_ component: [UIView]?) -> [UIView] {
    component ?? []
  }
}

#elseif os(macOS)

import AppKit

/// Result builder implementation for `NSView`.
/// - This is pretty the same as `ViewBuilder` from `SwiftUI`
@resultBuilder
public struct TetraUIViewBuilder {
  public static func buildBlock(_ components: [NSView]...) -> [NSView] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ component: NSView?) -> [NSView] {
    if let component = component {
      return [component]
    } else {
      return []
    }
  }

  public static func buildExpression(_ components: [NSView]...) -> [NSView] {
    components.flatMap { $0 }
  }

  public static func buildIf(_ components: [NSView]?...) -> [NSView] {
    components.compactMap { $0 }.flatMap { $0 }
  }

  public static func buildEither(first: [NSView]) -> [NSView] {
    first
  }

  public static func buildEither(second: [NSView]) -> [NSView] {
    second
  }

  public static func buildArray(_ components: [[NSView]]) -> [NSView] {
    components.flatMap({ $0 })
  }

  public static func buildOptional(_ component: [NSView]?) -> [NSView] {
    component ?? []
  }
}

#endif
