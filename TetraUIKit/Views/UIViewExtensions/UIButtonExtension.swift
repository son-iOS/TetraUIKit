//
//  UIButtonExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit
import Combine

public extension UIButton {

  /// Set the title for this button.
  @discardableResult func title(setTo title: String?, forState state: UIControl.State) -> Self {
    self.setTitle(title, for: state)
    return self
  }

  /// Set the title for this button using publisher.
  @discardableResult func title(
    setTo title: AnyPublisher<String?, Never>,
    forState state: UIControl.State,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    title.sink { [weak self] title in
      self?.title(setTo: title, forState: state)
    }.store(in: &cancellables)

    return self
  }

  /// Set the image for this button.
  @discardableResult func image(setTo image: UIImage?, forState state: UIControl.State) -> Self {
    self.setImage(image, for: state)
    return self
  }

  /// Set the image for this button using publisher.
  @discardableResult func image(
    setBy image: AnyPublisher<UIImage?, Never>,
    forState state: UIControl.State,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    image.sink { [weak self] image in
      self?.image(setTo: image, forState: state)
    }.store(in: &cancellables)

    return self
  }

  /// Set the title color for this button.
  @discardableResult func titleColor(setTo color: UIColor?, forState state: UIControl.State) -> Self {
    self.setTitleColor(color, for: state)
    return self
  }

  /// Set the title color for this button using publisher.
  @discardableResult func titleColor(
    setBy color: AnyPublisher<UIColor?, Never>,
    forState state: UIControl.State,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    color.sink { [weak self] color in
      self?.titleColor(setTo: color, forState: state)
    }.store(in: &cancellables)

    return self
  }

  /// Set the font for this button.
  @discardableResult func font(setTo font: UIFont) -> Self {
    self.titleLabel?.font = font
    return self
  }

  /// Set the font for this button using publisher.
  @discardableResult func font(
    setBy font: AnyPublisher<UIFont, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    font.sink { [weak self] font in
      self?.font(setTo: font)
    }.store(in: &cancellables)

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
