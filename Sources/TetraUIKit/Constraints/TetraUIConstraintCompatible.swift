//
//  TetraUIConstraintCompatible.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/27/22.
//

import UIKit

@MainActor public protocol TetraUIConstraintCompatible: AnyObject {
  var widthAnchor: NSLayoutDimension { get }
  var heightAnchor: NSLayoutDimension { get }

  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }

  var centerXAnchor: NSLayoutXAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }

  var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
  var lastBaselineAnchor: NSLayoutYAxisAnchor { get }

  var translatesAutoresizingMaskIntoConstraints: Bool { get set}
  var safeAreaLayoutGuide: UILayoutGuide { get }

  func addConstraints(@TetraUIConstraintBuilder _ constraints: () -> [NSLayoutConstraint])
}

public extension TetraUIConstraintCompatible {
  @MainActor func addConstraints(@TetraUIConstraintBuilder _ constraints: () -> [NSLayoutConstraint]) {
    translatesAutoresizingMaskIntoConstraints = false

    let constraints = constraints()
    for constraint in constraints {
      constraint.isActive = true
    }
  }

  internal static func makeConstraint<AnchorType>(
    firstAnchor: NSLayoutAnchor<AnchorType>?,
    secondAnchor: NSLayoutAnchor<AnchorType>?,
    offset: Double,
    relation: TetraUIConstraintRelation
  ) -> NSLayoutConstraint? {
    guard let firstAnchor = firstAnchor, let secondAnchor = secondAnchor else { return nil }

    switch relation {
    case .equal:
      return firstAnchor.constraint(equalTo: secondAnchor, constant: offset)
    case .greaterThanOrEqual:
      return firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor, constant: offset)
    case .lessThanOrEqual:
      return firstAnchor.constraint(lessThanOrEqualTo: secondAnchor, constant: offset)
    }
  }
}

// MARK: UIKit extensions

extension UIView: TetraUIConstraintCompatible {}
extension UILayoutGuide: TetraUIConstraintCompatible {
  public var firstBaselineAnchor: NSLayoutYAxisAnchor {
    fatalError("This object is a UILayoutGuide and it doesn't have firstBaselineAnchor")
  }

  public var lastBaselineAnchor: NSLayoutYAxisAnchor {
    fatalError("This object is a UILayoutGuide and it doesn't have lastBaselineAnchor")
  }

  public var safeAreaLayoutGuide: UILayoutGuide {
    return self
  }

  public var translatesAutoresizingMaskIntoConstraints: Bool {
    get {
      false
    }
    set {}
  }
}
