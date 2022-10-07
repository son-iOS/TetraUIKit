//
//  TetraUISelfAdjustable.swift
//  TetraUIUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit

/// In order to use declarative syntax with constraints or any customization that is not provided by `TetraUIKit`,
/// `UIView` has to be able to self adjust. Implement this protocol to do that.
/// - Before start implment your self-adjustable wrapper of views from UIKit, try classes with prefix `TetraUI` (e.g.
/// `TetraUIStackView` or `TetraUIImageView`. This lib already implemented some basic views for you.
/// - To conform to this protocol, simply add this to your class:
/// ```
///   var selfAdjustProcess: ((UIView, UIView?, [UIView]?) -> Void)?`
/// ```
public protocol TetraUISelfAdjustable: AnyObject {
  /// The self-adjust block. The arguments following the order are the view itself, its parent, and its siblings (including itself).
  var selfAdjustProcess: ((UIView, UIView?, [UIView]?) -> Void)? { get set }
}

public extension TetraUISelfAdjustable {
  /// Add a self-adjust block to the current view. The arguments following the order are the view itself, its parent,
  /// and its siblings (including itself). Set [independentlyAdjust] to true if the context of this view initialization is not as a subview.
  func selfAdjust(
    independentlyAdjust: Bool = false,
    adjustProcess: @escaping (UIView, UIView?, [UIView]?) -> Void
  ) -> Self {
    guard !independentlyAdjust else {
      if let this = self as? UIView {
        adjustProcess(this, this.superview, this.superview?.subviews)
      }
      return self
    }
    self.selfAdjustProcess = adjustProcess
    return self
  }
}
