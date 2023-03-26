//
//  UITextFieldExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/25/22.
//

import UIKit
import Combine

public extension UITextField {
  
  /// Create a text field with specified placeholder and/or text.
  convenience init(placeholder: String? = nil, text: String? = nil) {
    self.init()
    self.placeholder = placeholder
    self.text = text
  }
  
  /// Set the action for this text field.
  @discardableResult func target(_ target: Any?,
                                 action: Selector,
                                 for controlEvents: UIControl.Event) -> Self {
    self.addTarget(target, action: action, for: controlEvents)
    return self
  }

  /// Set the delegate for this text field.
  @discardableResult func delegate(_ delegate: UITextFieldDelegate?) -> Self {
    self.delegate = delegate
    return self
  }

  @discardableResult func text(
    setTo text: String?,
    updateWith textPublisher: AnyPublisher<String?, Never>? = nil
  ) -> Self {
    self.text = text
    if let view = self as? TetraUIViewCancellable {
      textPublisher?.sink(receiveValue: { [weak self] text in
        self?.text = text
      }).store(in: &view.viewCancellables)
    }
    return self
  }

  @discardableResult func attributedText(
    setTo text: NSAttributedString?,
    updateWith textPublisher: AnyPublisher<NSAttributedString?, Never>? = nil
  ) -> Self {
    self.attributedText = text
    if let view = self as? TetraUIViewCancellable {
      textPublisher?.sink(receiveValue: { [weak self] text in
        self?.attributedText = text
      }).store(in: &view.viewCancellables)
    }
    return self
  }
}
