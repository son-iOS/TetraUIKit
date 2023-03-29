//
//  TetraUISelfAdjustable.swift
//  TetraUIUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit
import Combine

/// In order to use declarative syntax with constraints or any customization that is not provided by `TetraUIKit`,
/// `UIView` has to be able to self adjust. Implement this protocol to do that.
/// - Before start implment your self-adjustable wrapper of views from UIKit, try classes with prefix `TetraUI` (e.g.
/// `TetraUIStackView` or `TetraUIImageView`. This lib already implemented some basic views for you.
/// - To conform to this protocol, simply add this to your class:
/// ```
///   var selfAdjustProcess: ((UIView, UIView?, [UIView]?) -> Void)?`
/// ```
public protocol TetraUISelfAdjustable: UIView {
  associatedtype ViewType: UIView
  /// The self-adjust block. The arguments following the order are the view itself, its parent, and its siblings (including itself).
  var selfAdjustProcess: ((ViewType, UIView?, [UIView]?) -> Void)? { get set }
}

public extension TetraUISelfAdjustable {
  /// Add a self-adjust block to the current view. The arguments following the order are the view itself, its parent,
  /// and its siblings (including itself). Set [independentlyAdjust] to true if the context of this view initialization is not as a subview.
  @discardableResult func selfAdjust(
    independentlyAdjust: Bool = false,
    adjustProcess: @escaping (UIView, UIView?, [UIView]?) -> Void
  ) -> Self {
    guard !independentlyAdjust else {
      adjustProcess(self, self.superview, self.superview?.subviews)
      return self
    }
    self.selfAdjustProcess = adjustProcess
    return self
  }

  /// Perform self adjustment if possible
  internal func performSelfAjustment() {
    guard let this = self as? ViewType else { return }
    selfAdjustProcess?(this, this.superview, this.superview?.subviews)
    selfAdjustProcess = nil
  }
}


public extension TetraUISelfAdjustable {
  /// Set the property of [keyPath] to [value]
  @discardableResult func property<T>(
    _ keyPath: ReferenceWritableKeyPath<ViewType, T>,
    setTo value: T,
    updateWith valuePublisher: AnyPublisher<T, Never>? = nil,
    animationDuration: TimeInterval? = nil
  ) -> Self {
    guard let this = self as? ViewType else { return self }
    this[keyPath: keyPath] = value
    if let view = this as? TetraUIViewCancellable {
      valuePublisher?
        .sink(receiveValue: { [weak this] value in
          if let duration = animationDuration {
            UIView.animate(withDuration: duration) {
              this?[keyPath: keyPath] = value
            }
          } else {
            this?[keyPath: keyPath] = value
          }
        })
        .store(in: &view.viewCancellables)
    }
    return self
  }

  /// Set the nested property of [keyPath] to [value]
  @discardableResult func nestedProperty<T>(
    _ keyPath: KeyPath<ViewType, T>,
    setTo value: T,
    updateWith valuePublisher: AnyPublisher<T, Never>? = nil,
    animationDuration: TimeInterval? = nil
  ) -> Self {
    guard let this = self as? ViewType,
          let keyPath = keyPath as? ReferenceWritableKeyPath<ViewType, T> else {
      return self
    }
    this[keyPath: keyPath] = value
    if let view = this as? TetraUIViewCancellable {
      valuePublisher?
        .sink(receiveValue: { [weak this] value in
          if let duration = animationDuration {
            UIView.animate(withDuration: duration) {
              this?[keyPath: keyPath] = value
            }
          } else {
            this?[keyPath: keyPath] = value
          }
        })
        .store(in: &view.viewCancellables)
    }
    return self
  }
}

