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
}
