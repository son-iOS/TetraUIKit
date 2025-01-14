//
//  TetraUIConstraintType.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/25/22.
//

import UIKit
import Combine

/// Enum to specify generic constraint type
public enum TetraUIConstraintType: Sendable {
  case firstBaseline, lastBaseline
  case centerX, centerY
  case leading, trailing, top, bottom

  private static let xTypes: [TetraUIConstraintType] = [
    .leading, .trailing, .centerX
  ]
  private static let yTypes: [TetraUIConstraintType] = [
    .top, .bottom, .centerY, .firstBaseline, .lastBaseline
  ]

  internal func isCompatible(with otherType: TetraUIConstraintType) -> Bool {
    let areBothXTypes = Self.xTypes.contains(self) && Self.xTypes.contains(otherType)
    let areBothYTypes = Self.yTypes.contains(self) && Self.yTypes.contains(otherType)
    return areBothXTypes || areBothYTypes
  }
}

public extension TetraUIConstraintCompatible {
  private func xAnchor(forType type: TetraUIConstraintType) -> NSLayoutXAxisAnchor? {
    switch type {
    case .centerX:
      return centerXAnchor
    case .leading:
      return leadingAnchor
    case .trailing:
      return trailingAnchor
    case .centerY, .top, .bottom, .firstBaseline, .lastBaseline:
      return nil
    }
  }

  private func yAnchor(forType type: TetraUIConstraintType) -> NSLayoutYAxisAnchor? {
    switch type {
    case .centerY:
      return centerYAnchor
    case .top:
      return topAnchor
    case .bottom:
      return bottomAnchor
    case .firstBaseline:
      return firstBaselineAnchor
    case .lastBaseline:
      return lastBaselineAnchor
    case .centerX, .leading, .trailing:
      return nil
    }
  }

  /// Add constraints to align center x and center y to [other]'s center.
  @discardableResult func centered(in other: TetraUIConstraintCompatible?) -> Self {
    guard let other = other else { return self }

    addConstraints {
      centerXAnchor.constraint(equalTo: other.centerXAnchor)
      centerYAnchor.constraint(equalTo: other.centerYAnchor)
    }

    return self
  }

  /// Add constraint to make [type] of this view or layout guide appear after (if in x-axis) or below (if in y-axis) [other]'s [type],
  /// multiplied with system spacing by [multiplier]
  @discardableResult func constraintType(
    _ type: TetraUIConstraintType,
    placedBelowOrAfter other: TetraUIConstraintCompatible?,
    withMultiplier multiplier: Double
  ) -> Self {
    guard [.centerX, .centerY, .firstBaseline, .lastBaseline].contains(type),
          let other = other else {
      return self
    }

    addConstraints {
      switch type {
      case .centerX:
        centerYAnchor.constraint(
          equalToSystemSpacingBelow: other.centerYAnchor,
          multiplier: multiplier
        )
      case .centerY:
        centerXAnchor.constraint(
          equalToSystemSpacingAfter: other.centerXAnchor,
          multiplier: multiplier
        )
      case .firstBaseline:
        firstBaselineAnchor.constraint(
          equalToSystemSpacingBelow: other.firstBaselineAnchor,
          multiplier: multiplier
        )
      case .lastBaseline:
        lastBaselineAnchor.constraint(
          equalToSystemSpacingBelow: other.lastBaselineAnchor,
          multiplier: multiplier
        )
      case .leading, .trailing, .top, .bottom:
        nil
      }
    }

    return self
  }

  /// Add constraint to make this view or layout guide's [type] aligned to [other]'s [toType].
  /// You can also supply the [offset] and [relation].
  @discardableResult
  func constraintType(_ type: TetraUIConstraintType,
                      constrainedTo toType: TetraUIConstraintType,
                      of other: TetraUIConstraintCompatible?,
                      withOffset offset: Double = 0,
                      updateOffsetWith offsetPublisher: AnyPublisher<Double, Never>? = nil,
                      relation: TetraUIConstraintRelation = .equal) -> Self {
    guard type.isCompatible(with: toType), let other = other else { return self }

    let constraint: NSLayoutConstraint?
    switch type {
    case .centerY, .firstBaseline, .lastBaseline, .top, .bottom:
      constraint = Self.makeConstraint(
        firstAnchor: yAnchor(forType: type),
        secondAnchor: other.yAnchor(forType: toType),
        offset: offset,
        relation: relation
      )
    case .centerX, .leading, .trailing:
      constraint = Self.makeConstraint(
        firstAnchor: xAnchor(forType: type),
        secondAnchor: other.xAnchor(forType: toType),
        offset: offset,
        relation: relation
      )
    }

    addConstraints { constraint }

    if let offsetPublisher = offsetPublisher, let view = self as? TetraUIViewCancellable {
      offsetPublisher.sink { [weak constraint] offset in
        guard offset != .infinity && offset != -.infinity && offset != .nan else { return}
        constraint?.constant = offset
      }.store(in: &view.viewCancellables)
    }

    return self
  }
}
