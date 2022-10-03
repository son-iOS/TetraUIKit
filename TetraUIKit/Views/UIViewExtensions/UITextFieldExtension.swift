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
  
  /// Set the border style of this text field.
  @discardableResult func borderStyle(_ style: UITextField.BorderStyle) -> Self {
    self.borderStyle = style
    return self
  }
  
  /// Set the border style for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func borderStyle(
    _ style: AnyPublisher<UITextField.BorderStyle, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    style.sink { [weak self] style in
      self?.borderStyle(style)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the state of this text field.
  @discardableResult func isEnabled(_ isEnabled: Bool) -> Self {
    self.isEnabled = isEnabled
    return self
  }
  
  /// Set the state for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func isEnabled(
    _ isEnabled: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    isEnabled.sink { [weak self] isEnabled in
      self?.isEnabled(isEnabled)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the autocorrection type of this text field.
  @discardableResult func autocorrectionType(_ type: UITextAutocorrectionType) -> Self {
    self.autocorrectionType = type
    return self
  }
  
  /// Set the autocorrection type for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func autocorrectionType(
    _ type: AnyPublisher<UITextAutocorrectionType, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    type.sink { [weak self] type in
      self?.autocorrectionType(type)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the text of this text field.
  @discardableResult func text(_ text: String?) -> Self {
    self.text = text
    return self
  }
  
  /// Set the text for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func text(
    _ text: AnyPublisher<String?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    text.sink { [weak self] text in
      self?.text(text)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the placeholder of this text field.
  @discardableResult func placeholder(_ placeholder: String?) -> Self {
    self.placeholder = placeholder
    return self
  }
  
  /// Set the placeholder for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func placeholder(
    _ placeholder: AnyPublisher<String?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    placeholder.sink { [weak self] placeholder in
      self?.placeholder(placeholder)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the attributed text of this text field.
  @discardableResult func attributedText(_ text: NSAttributedString?) -> Self {
    self.attributedText = text
    return self
  }
  
  /// Set the attributed text for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func attributedText(
    _ text: AnyPublisher<NSAttributedString?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    text.sink { [weak self] text in
      self?.attributedText(text)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the text color of this text field.
  @discardableResult func textColor(_ color: UIColor?) -> Self {
    self.textColor = color
    return self
  }
  
  /// Set the text color for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func textColor(
    _ color: AnyPublisher<UIColor?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    color.sink { [weak self] color in
      self?.textColor(color)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the font of this text field.
  @discardableResult func font(_ font: UIFont) -> Self {
    self.font = font
    return self
  }
  
  /// Set the font for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func font(
    _ font: AnyPublisher<UIFont, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    font.sink { [weak self] font in
      self?.font(font)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the alignment of this text field.
  @discardableResult func textAlignment(_ alignment: NSTextAlignment) -> Self {
    self.textAlignment = alignment
    return self
  }
  
  /// Set the alignment for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func textAlignment(
    _ alignment: AnyPublisher<NSTextAlignment, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    alignment.sink { [weak self] alignment in
      self?.textAlignment(alignment)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the right view of this text field.
  @discardableResult func rightView(_ view: UIView, mode: UITextField.ViewMode) -> Self {
    self.rightView = view
    self.rightViewMode = mode
    return self
  }
  
  /// Set the right view for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func rightView(
    _ view: AnyPublisher<UIView, Never>,
    mode: UITextField.ViewMode,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    view.sink { [weak self] view in
      self?.rightView(view, mode: mode)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the left view of this text field.
  @discardableResult func leftView(_ view: UIView, mode: UITextField.ViewMode) -> Self {
    self.leftView = view
    self.leftViewMode = mode
    return self
  }
  
  /// Set the left view for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func leftView(
    _ view: AnyPublisher<UIView, Never>,
    mode: UITextField.ViewMode,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    view.sink { [weak self] view in
      self?.leftView(view, mode: mode)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the input accessory view of this text field.
  @discardableResult func inputAccessoryView(_ view: UIView) -> Self {
    self.inputAccessoryView = view
    return self
  }
  
  /// Set the input accessory view for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func inputAccessoryView(
    _ view: AnyPublisher<UIView, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    view.sink { [weak self] view in
      self?.inputAccessoryView(view)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the keyboard type of this text field.
  @discardableResult func keyboardType(_ type: UIKeyboardType) -> Self {
    self.keyboardType = type
    return self
  }
  
  /// Set the keyboard type for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func keyboardType(
    _ type: AnyPublisher<UIKeyboardType, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    type.sink { [weak self] type in
      self?.keyboardType(type)
    }.store(in: &cancellables)
    
    return self
  }
  
  /// Set the action for this text field.
  @discardableResult func target(_ target: Any?,
                                 action: Selector,
                                 for controlEvents: UIControl.Event) -> Self {
    self.addTarget(target, action: action, for: controlEvents)
    return self
  }
  
  /// Set the action for this text field using publisher.
  @available(iOS 13.0, *)
  @discardableResult func target(
    _ target: Any?,
    action: AnyPublisher<Selector, Never>,
    for controlEvents: UIControl.Event,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    if let target = target as AnyObject? {
      action.sink { [weak self, weak target] action in
        self?.target(target, action: action, for: controlEvents)
      }.store(in: &cancellables)
    } else {
      action.sink { [weak self] action in
        self?.target(target, action: action, for: controlEvents)
      }.store(in: &cancellables)
    }
    
    return self
  }

  /// Set the delegate for this text field.
  @discardableResult func delegate(_ delegate: UITextFieldDelegate?) -> Self {
    self.delegate = delegate
    return self
  }
}
