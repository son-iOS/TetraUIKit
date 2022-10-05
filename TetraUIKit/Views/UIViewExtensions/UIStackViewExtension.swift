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
    self.axis = axis
    self.spacing = spacing
    let children = arrangedChildren()
    for child in children {
      addArrangedSubview(child)

      if child.tag == 0 && arrangedSubviews.count > 1 {
        child.tag = arrangedSubviews.count - 1
      }
    }

    for child in children where child is TetraUISelfAdjustable {
      (child as? TetraUISelfAdjustable)?.selfAdjustProcess?(child, self, children)
    }
  }

  /// Add custom spacing for this stack view.
  @discardableResult func customSpacing(_ spacing: CGFloat, after view: UIView) -> Self {
    self.setCustomSpacing(spacing, after: view)
    return self
  }

  /// Set custom spacing of this stack view using publisher.
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
