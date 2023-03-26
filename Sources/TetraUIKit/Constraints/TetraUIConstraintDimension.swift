//
//  TetraUIConstraintDimension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/26/22.
//

import UIKit
import Combine

/// Enum used to specify dimension of a view or layout guide.
public enum TetraUIConstraintDimension {
  case width, height
}

public extension TetraUIConstraintCompatible {
  private func anchor(forDimension dimension: TetraUIConstraintDimension) -> NSLayoutDimension {
    switch dimension {
    case .width:
      return widthAnchor
    case .height:
      return heightAnchor
    }
  }

  /// Add both width and height constraints using values from the provided `size`.  Can provide option [sizePublisher]
  /// to update
  @discardableResult func size(
    setTo size: CGSize,
    updateWith sizePublisher: AnyPublisher<CGSize, Never>? = nil
  ) -> Self {
    let widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
    let heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
    addConstraints {
      widthConstraint
      heightConstraint
    }

    if let sizePublisher = sizePublisher, let view = self as? TetraUIViewCancellable {
      sizePublisher.sink { [weak widthConstraint, weak heightConstraint] size in
        widthConstraint?.constant = size.width
        heightConstraint?.constant = size.height
      }.store(in: &view.viewCancellables)
    }

    return self
  }

  /// Add [dimension] constraint using value from the provided [size], applied with [relation]. Can provide option [sizePublisher]
  /// to update. Publisher only works if this view conforms to  [TetraUIViewCancellable]
  @discardableResult func dimension(
    _ dimension: TetraUIConstraintDimension,
    setTo size: Double,
    updateWith sizePublisher: AnyPublisher<Double, Never>? = nil,
    withRelation relation: TetraUIConstraintRelation = .equal
  ) -> Self {
    let thisDimensionAnchor = anchor(forDimension: dimension)
    let constraint: NSLayoutConstraint
    switch relation {
    case .equal:
      constraint = thisDimensionAnchor.constraint(equalToConstant: size)
    case .greaterThanOrEqual:
      constraint = thisDimensionAnchor.constraint(greaterThanOrEqualToConstant: size)
    case .lessThanOrEqual:
      constraint = thisDimensionAnchor.constraint(lessThanOrEqualToConstant: size)
    }
    addConstraints { constraint }

    if let sizePublisher = sizePublisher, let view = self as? TetraUIViewCancellable {
      sizePublisher.sink { [weak constraint] size in
        constraint?.constant = size
      }.store(in: &view.viewCancellables)
    }

    return self
  }

  /// Add [dimension] constraint in [relation] respectively to [toDimension] of [other].
  /// You can also add [offset] and [multiplier].
  @discardableResult func dimension(
    _ dimension: TetraUIConstraintDimension,
    matchedToOtherDimension otherDimension: TetraUIConstraintDimension,
    of other: TetraUIConstraintCompatible?,
    withMultiplier multiplier: Double = 1,
    offset: Double = 0,
    updateOffsetWith offsetPublisher: AnyPublisher<Double, Never>? = nil,
    relation: TetraUIConstraintRelation = .equal
  ) -> Self {
    guard let other = other else { return self }

    let thisDimensionAnchor = anchor(forDimension: dimension)
    let otherDimensionAnchor = other.anchor(forDimension: otherDimension)

    let constraint: NSLayoutConstraint
    switch relation {
    case .equal:
      constraint = thisDimensionAnchor.constraint(
        equalTo: otherDimensionAnchor,
        multiplier: multiplier,
        constant: offset
      )
    case .greaterThanOrEqual:
      constraint = thisDimensionAnchor.constraint(
        greaterThanOrEqualTo: otherDimensionAnchor,
        multiplier: multiplier,
        constant: offset
      )
    case .lessThanOrEqual:
      constraint = thisDimensionAnchor.constraint(
        lessThanOrEqualTo: otherDimensionAnchor,
        multiplier: multiplier,
        constant: offset
      )
    }

    addConstraints { constraint }

    if let offsetPublisher = offsetPublisher, let view = self as? TetraUIViewCancellable {
      offsetPublisher.sink { [weak constraint] offset in
        constraint?.constant = offset
      }.store(in: &view.viewCancellables)
    }

    return self
  }
}
