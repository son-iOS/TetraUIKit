//
//  UIButtonExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import Combine

#if os(iOS)

import UIKit

public extension UIButton {

  /// Set the title for this button.
  @discardableResult func title(
    setTo title: String?,
    updateWith titlePublisher: AnyPublisher<String?, Never>? = nil,
    forState state: UIControl.State
  ) -> Self {
    self.setTitle(title, for: state)

    if let view = self as? TetraUIViewCancellable {
      titlePublisher?.sink { [weak self] title in
        self?.setTitle(title, for: state)
      }.store(in: &view.viewCancellables)
    }

    return self
  }

  /// Set the image for this button.
  @discardableResult func image(
    setTo image: UIImage?,
    updateWith imagePublisher: AnyPublisher<UIImage?, Never>? = nil,
    forState state: UIControl.State
  ) -> Self {
    self.setImage(image, for: state)
    if let view = self as? TetraUIViewCancellable {
      imagePublisher?.sink { [weak self] image in
        self?.setImage(image, for: state)
      }.store(in: &view.viewCancellables)
    }
    return self
  }

  /// Set the title color for this button.
  @discardableResult func titleColor(
    setTo color: UIColor?,
    updateWith colorPublisher: AnyPublisher<UIColor?, Never>? = nil,
    forState state: UIControl.State
  ) -> Self {
    self.setTitleColor(color, for: state)
    if let view = self as? TetraUIViewCancellable {
      colorPublisher?.sink { [weak self] color in
        self?.setTitleColor(color, for: state)
      }.store(in: &view.viewCancellables)
    }
    return self
  }

  /// Set the font for this button.
  @discardableResult func font(
    setTo font: UIFont,
    updateWith fontPublisher: AnyPublisher<UIFont, Never>? = nil
  ) -> Self {
    self.titleLabel?.font = font
    if let view = self as? TetraUIViewCancellable {
      fontPublisher?.sink { [weak self] font in
        self?.titleLabel?.font = font
      }.store(in: &view.viewCancellables)
    }
    return self
  }

  /// Set the action for this button.
  @discardableResult func target(_ target: Any?,
                                 action: Selector,
                                 addedForEvent controlEvents: UIControl.Event) -> Self {
    self.addTarget(target, action: action, for: controlEvents)
    return self
  }
}

#endif
