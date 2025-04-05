//
//  UILabelExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import Combine

#if os(iOS)

import UIKit

public extension UILabel {
  /// Create a lable with the specified [text].
  convenience init(_ text: String?) {
    self.init()
    self.text = text
  }

  /// Create a lable with the specified [attributedText].
  convenience init(_ attributedText: NSAttributedString?) {
    self.init()
    self.attributedText = attributedText
  }

  /// Sometimes multi-line label doesn't work very well with stack view. Use this to make the label more compatible with stack view.
  /// This simply wrap the label inside a `UIView` and pin the edges to the label to the container view.
  @discardableResult func wrappedInContainer(withInsets insets: UIEdgeInsets = .zero) -> UIView {
    let container = UIView()
    container.subview(self, addedWithInsets: insets)
    return container
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

#elseif os(macOS)

import AppKit

public extension NSText {
  /// Create a lable with the specified [text].
  convenience init(_ text: String?) {
    self.init()
    if let text {
      self.string = text
    }
  }

  /// Sometimes multi-line label doesn't work very well with stack view. Use this to make the label more compatible with stack view.
  /// This simply wrap the label inside a `UIView` and pin the edges to the label to the container view.
  @discardableResult func wrappedInContainer(
    withInsets insets: NSEdgeInsets = .zero
  ) -> NSView {
    let container = NSView()
    container.subview(self, addedWithInsets: insets)
    return container
  }

  @discardableResult func text(
    setTo text: String?,
    updateWith textPublisher: AnyPublisher<String?, Never>? = nil
  ) -> Self {
    if let text {
      self.string = text
    }
    if let view = self as? TetraUIViewCancellable {
      textPublisher?.sink(receiveValue: { [weak self] text in
        guard let text else { return }
        self?.string = text
      }).store(in: &view.viewCancellables)
    }
    return self
  }
}

#endif
