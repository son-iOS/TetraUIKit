//
//  UIScrollViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

public extension UIScrollView {
  @discardableResult func contentSize(_ size: CGSize) -> Self {
    self.contentSize = size
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult func contentSize(
    _ size: AnyPublisher<CGSize, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    size.sink { [weak self] size in
      self?.contentSize = size
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func contentOffset(_ offset: CGPoint, animated: Bool) -> Self {
    self.setContentOffset(offset, animated: animated)
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult func contentOffset(
    _ offset: AnyPublisher<CGPoint, Never>,
    animated: Bool,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    offset.sink { [weak self] offset in
      self?.setContentOffset(offset, animated: animated)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func contentInset(_ inset: UIEdgeInsets) -> Self {
    self.contentInset = inset
    return self
  }

  @available(iOS 13.0, *)
  @discardableResult func contentInset(
    _ inset: AnyPublisher<UIEdgeInsets, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    inset.sink { [weak self] inset in
      self?.contentInset = inset
    }.store(in: &cancellables)

    return self
  }

  /// Set the delegate for this scroll view.
  @discardableResult func delegate(_ delegate: UIScrollViewDelegate?) -> Self {
    self.delegate = delegate
    return self
  }
}
