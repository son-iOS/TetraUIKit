//
//  UIStackViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit
import Combine

public extension UIStackView {
  /// Create a stack view in [axis] directionwith specified [arrangedChildren],  each child is [spacing] apart from each other.
  ///Children will be tagged with the order within the array.
  convenience init(axis: NSLayoutConstraint.Axis = .vertical,
                   spacing: CGFloat = 0,
                   @TetraUIViewBuilder with arrangedChildren: () -> [UIView]) {
    self.init()
    self.axis(axis)
    self.spacing(spacing)
    let children = arrangedChildren()
    for child in children {
      addArrangedSubview(child)

      if child.tag == 0 && arrangedSubviews.count > 1 {
        child.tag = arrangedSubviews.count - 1
      }
    }

    for child in children where child is TetraUISelfLayoutable {
      (child as? TetraUISelfLayoutable)?.selfLayoutProcess?(child, self, children)
    }
  }

  /// Set the axis of this stack view.
  @discardableResult func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
    self.axis = axis
    return self
  }

  /// Set the axis of this stack view using publisher.
  @available(iOS 13.0, *)
  @discardableResult func axis(
    _ axis: AnyPublisher<NSLayoutConstraint.Axis, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    axis.sink { [weak self] axis in
      self?.axis = axis
    }.store(in: &cancellables)

    return self
  }

  /// Add padding around the stack view
  @discardableResult func spacing(_ spacing: CGFloat) -> Self {
    self.spacing = spacing
    return self
  }

  /// Set the spacing of this stack view using publisher.
  @available(iOS 13.0, *)
  @discardableResult func spacing(
    _ spacing: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    spacing.sink { [weak self] spacing in
      self?.spacing = spacing
    }.store(in: &cancellables)

    return self
  }

  /// Add custom spacing for this stack view.
  @discardableResult func customSpacing(_ spacing: CGFloat, after view: UIView) -> Self {
    self.setCustomSpacing(spacing, after: view)
    return self
  }

  /// Set custom spacing of this stack view using publisher.
  @available(iOS 13.0, *)
  @discardableResult func customSpacing(
    _ spacing: AnyPublisher<CGFloat, Never>,
    after view: UIView,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    spacing.sink { [weak self, weak view] spacing in
      if let view = view {
        self?.customSpacing(spacing, after: view)
      }
    }.store(in: &cancellables)

    return self
  }

  /// Add padding around the stack view.
  @discardableResult func insets(_ insets: UIEdgeInsets) -> Self {
    self.isLayoutMarginsRelativeArrangement = true
    let convertedInsets = UIEdgeInsets(top: insets.top,
                                       left: insets.left,
                                       bottom: -insets.bottom,
                                       right: -insets.right)
    self.layoutMargins = convertedInsets
    return self
  }

  /// Set padding of this stack view using publisher.
  @available(iOS 13.0, *)
  @discardableResult func insets(
    _ insets: AnyPublisher<UIEdgeInsets, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    self.isLayoutMarginsRelativeArrangement = true
    insets.sink { [weak self] insets in
      let convertedInsets = UIEdgeInsets(top: insets.top,
                                         left: insets.left,
                                         bottom: -insets.bottom,
                                         right: -insets.right)
      self?.layoutMargins = convertedInsets
    }.store(in: &cancellables)

    return self
  }
}
