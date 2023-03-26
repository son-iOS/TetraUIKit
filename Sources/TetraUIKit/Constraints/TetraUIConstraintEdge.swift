//
//  TetraUIConstraintEdge.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 2/26/22.
//

import UIKit
import SwiftUI
import Combine

/// Enum used to specify constraint edge.
public enum TetraUIConstraintEdge: CaseIterable {
  case leading, trailing, top, bottom

  private static let xEdges: [TetraUIConstraintEdge] = [.leading, .trailing]
  private static let yEdges: [TetraUIConstraintEdge] = [.top, .bottom]

  internal func isCompatible(with otherEdge: TetraUIConstraintEdge) -> Bool {
    let areBothXEdges = Self.xEdges.contains(self) && Self.xEdges.contains(otherEdge)
    let areBothYEdges = Self.yEdges.contains(self) && Self.yEdges.contains(otherEdge)
    return areBothXEdges || areBothYEdges
  }
}

public extension TetraUIConstraintCompatible {
  private func xAnchor(forEdge edge: TetraUIConstraintEdge) -> NSLayoutXAxisAnchor? {
    switch edge {
    case .leading:
      return leadingAnchor
    case .trailing:
      return trailingAnchor
    case .top, .bottom:
      return nil
    }
  }

  private func yAnchor(forEdge edge: TetraUIConstraintEdge) -> NSLayoutYAxisAnchor? {
    switch edge {
    case .top:
      return topAnchor
    case .bottom:
      return bottomAnchor
    case .leading, .trailing:
      return nil
    }
  }

  /// Add constraints to all edges of this view or layout guide to [other], excluding [edges].
  /// You can also add [insets] and [relation] to the constraints.
  /// If [userSafeArea] is true, the safe area layout guide of a view will be used.
  @discardableResult func edgesPinnedToEdges(
    of other: TetraUIConstraintCompatible?,
    excludingEdeges edges: Set<TetraUIConstraintEdge>? = nil,
    withInset insets: UIEdgeInsets = .zero,
    updateInsetWith insetsPublihser: AnyPublisher<UIEdgeInsets, Never>? = nil,
    relation: TetraUIConstraintRelation = .equal,
    useSafeArea: Bool = false
  ) -> Self {
    guard let other = useSafeArea ? other?.safeAreaLayoutGuide : other else { return self }

    let edges = TetraUIConstraintEdge.allCases.filter({ !(edges?.contains($0) ?? false) })
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    for edge in edges {
      switch edge {
      case .leading:
        leadingConstraint = Self.makeConstraint(
          firstAnchor: leadingAnchor,
          secondAnchor: other.leadingAnchor,
          offset: insets.left,
          relation: relation
        )
      case .trailing:
        trailingConstraint = Self.makeConstraint(
          firstAnchor: trailingAnchor,
          secondAnchor: other.trailingAnchor,
          offset: insets.right,
          relation: relation
        )
      case .top:
        topConstraint = Self.makeConstraint(
          firstAnchor: topAnchor,
          secondAnchor: other.topAnchor,
          offset: insets.top,
          relation: relation
        )
      case .bottom:
        bottomConstraint = Self.makeConstraint(
          firstAnchor: bottomAnchor,
          secondAnchor: other.bottomAnchor,
          offset: insets.bottom,
          relation: relation
        )
      }
    }
    addConstraints {
      leadingConstraint
      trailingConstraint
      topConstraint
      bottomConstraint
    }

    if let insetsPublihser = insetsPublihser, let view = self as? TetraUIViewCancellable {
      insetsPublihser.sink { [
        weak leadingConstraint,
        weak trailingConstraint,
        weak topConstraint,
        weak bottomConstraint
      ] insets in
        leadingConstraint?.constant = insets.left
        trailingConstraint?.constant = insets.right
        topConstraint?.constant = insets.top
        bottomConstraint?.constant = insets.bottom
      }.store(in: &view.viewCancellables)
    }

    return self
  }

  /// Add constraints to [edge] of this view or layout guide to [other]'s [otherEdge].
  /// You can also add [insets] and [relation] to the constraints.
  /// [edge] and [otherEdge] have to be compatible to each other.
  /// If [userSafeArea] is true, the safe area layout guide of a view will be used.
  @discardableResult
  func edge(
    _ edge: TetraUIConstraintEdge,
    pinnedToOtherEdge otherEdge: TetraUIConstraintEdge,
    of other: TetraUIConstraintCompatible?,
    withOffset offset: Double = 0,
    updateOffsetWith offsetPublisher: AnyPublisher<Double, Never>? = nil,
    relation: TetraUIConstraintRelation = .equal,
    useSafeArea: Bool = false
  ) -> Self {
    guard edge.isCompatible(with: otherEdge),
          let other = useSafeArea ? other?.safeAreaLayoutGuide : other else {
      return self
    }

    let constraint: NSLayoutConstraint?
    switch edge {
    case .leading, .trailing:
      constraint = Self.makeConstraint(
        firstAnchor: xAnchor(forEdge: edge),
        secondAnchor: other.xAnchor(forEdge: otherEdge),
        offset: offset,
        relation: relation
      )
    case .top, .bottom:
      constraint = Self.makeConstraint(
        firstAnchor: yAnchor(forEdge: edge),
        secondAnchor: other.yAnchor(forEdge: otherEdge),
        offset: offset,
        relation: relation
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
