//
//  TetraUIConstraintDimension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/26/22.
//

import UIKit

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

  /// Add both width and height constraints using values from the provided `size`
  @discardableResult func size(setTo size: CGSize) -> Self {
    addConstraints {
      widthAnchor.constraint(equalToConstant: size.width)
      heightAnchor.constraint(equalToConstant: size.height)
    }

    return self
  }

  /// Add [dimension] constraint using value from the provided [size], applied with [relation]
  @discardableResult func dimension(
    _ dimension: TetraUIConstraintDimension,
    setTo size: Double,
    withRelation relation: TetraUIConstraintRelation = .equal
  ) -> Self {
    let thisDimensionAnchor = anchor(forDimension: dimension)
    addConstraints {
      switch relation {
      case .equal:
        thisDimensionAnchor.constraint(equalToConstant: size)
      case .greaterThanOrEqual:
        thisDimensionAnchor.constraint(greaterThanOrEqualToConstant: size)
      case .lessThanOrEqual:
        thisDimensionAnchor.constraint(lessThanOrEqualToConstant: size)
      }
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
    relation: TetraUIConstraintRelation = .equal
  ) -> Self {
    guard let other = other else { return self }

    let thisDimensionAnchor = anchor(forDimension: dimension)
    let otherDimensionAnchor = other.anchor(forDimension: otherDimension)
    addConstraints {
      switch relation {
      case .equal:
        thisDimensionAnchor.constraint(
          equalTo: otherDimensionAnchor,
          multiplier: multiplier,
          constant: offset
        )
      case .greaterThanOrEqual:
        thisDimensionAnchor.constraint(
          greaterThanOrEqualTo: otherDimensionAnchor,
          multiplier: multiplier,
          constant: offset
        )
      case .lessThanOrEqual:
        thisDimensionAnchor.constraint(
          lessThanOrEqualTo: otherDimensionAnchor,
          multiplier: multiplier,
          constant: offset
        )
      }
    }

    return self
  }
}
