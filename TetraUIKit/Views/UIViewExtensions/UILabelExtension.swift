//
//  UILabelExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit
import Combine

public extension UILabel {
  /// Create a lable with the specified [text].
  convenience init(_ text: String?) {
    self.init()
    self.text(text)
  }

  /// Create a lable with the specified [attributedText].
  convenience init(_ attributedText: NSAttributedString?) {
    self.init()
    self.attributedText(attributedText)
  }

  /// Set the text of this label.
  @discardableResult func text(_ text: String?) -> Self {
    self.text = text
    return self
  }

  /// Set the text of this label using publisher.
  @available(iOS 13.0, *)
  @discardableResult func text(
    _ text: AnyPublisher<String?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    text.sink { [weak self] text in
      self?.text = text
    }.store(in: &cancellables)

    return self
  }

  /// Set the attributed text of this label.
  @discardableResult func attributedText(_ text: NSAttributedString?) -> Self {
    self.attributedText = text
    return self
  }

  /// Set the attributed text of this label using publisher.
  @available(iOS 13.0, *)
  @discardableResult func attributedText(
    _ text: AnyPublisher<NSAttributedString?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    text.sink { [weak self] text in
      self?.attributedText = text
    }.store(in: &cancellables)

    return self
  }

  /// Set the text color of this label.
  @discardableResult func textColor(_ color: UIColor?) -> Self {
    self.textColor = color
    return self
  }

  /// Set the text color of this label using publisher.
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

  /// Set the font of this label.
  @discardableResult func font(_ font: UIFont) -> Self {
    self.font = font
    return self
  }

  /// Set the font of this label using publisher.
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

  /// Set the number of lines of this label.
  @discardableResult func numberOfLines(_ lineCount: Int) -> Self {
    self.numberOfLines = lineCount
    return self
  }

  /// Set the number of lines of this label using publisher.
  @available(iOS 13.0, *)
  @discardableResult func numberOfLines(
    _ lineCount: AnyPublisher<Int, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    lineCount.sink { [weak self] lineCount in
      self?.numberOfLines(lineCount)
    }.store(in: &cancellables)

    return self
  }

  /// Set the text alignment of this label.
  @discardableResult func textAlignment(_ alignment: NSTextAlignment) -> Self {
    self.textAlignment = alignment
    return self
  }

  /// Set the text alignment of this label using publisher.
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

  /// Set the line break mode of this label.
  @discardableResult func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
    self.lineBreakMode = mode
    return self
  }

  /// Set the line break mode of this label using publisher.
  @available(iOS 13.0, *)
  @discardableResult func lineBreakMode(
    _ mode: AnyPublisher<NSLineBreakMode, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    mode.sink { [weak self] mode in
      self?.lineBreakMode(mode)
    }.store(in: &cancellables)

    return self
  }

  /// Set the line break strategy of this label.
  @discardableResult func lineBreakStrategy(
    _ strategy: NSParagraphStyle.LineBreakStrategy
  ) -> Self {
    self.lineBreakStrategy = strategy
    return self
  }

  /// Set the line break strategy of this label using publisher.
  @available(iOS 13.0, *)
  @discardableResult func lineBreakStrategy(
    _ strategy: AnyPublisher<NSParagraphStyle.LineBreakStrategy, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    strategy.sink { [weak self] strategy in
      self?.lineBreakStrategy(strategy)
    }.store(in: &cancellables)

    return self
  }

  /// Sometimes multi-line label doesn't work very well with stack view. Use this to make the label more compatible with stack view.
  /// This simply wrap the label inside a `UIView` and pin the edges to the label to the container view.
  @discardableResult func wrappedInContainer(withInsets insets: UIEdgeInsets = .zero) -> UIView {
    let container = UIView()
    container.addSubview(self, withInsets: insets)
    return container
  }
}
