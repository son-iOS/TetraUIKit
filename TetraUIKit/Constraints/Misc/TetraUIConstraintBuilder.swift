//
//  TetraUIConstraintBuilder.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/26/22.
//

import UIKit

/// Result builder implementation for `NSLayoutConstraint`.
/// - This is pretty the same as `ViewBuilder` from `SwiftUI`
@resultBuilder
public struct TetraUIConstraintBuilder {
  public static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ component: NSLayoutConstraint?) -> [NSLayoutConstraint] {
    if let component = component {
      return [component]
    } else {
      return []
    }
  }

  public static func buildExpression(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
    components.flatMap { $0 }
  }

  public static func buildIf(_ components: [NSLayoutConstraint]?...) -> [NSLayoutConstraint] {
    components.compactMap { $0 }.flatMap { $0 }
  }

  public static func buildEither(first: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    first
  }

  public static func buildEither(second: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    second
  }

  public static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
    components.flatMap({ $0 })
  }

  public static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
    return component ?? []
  }
}
