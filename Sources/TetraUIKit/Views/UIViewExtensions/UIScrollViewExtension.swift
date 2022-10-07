//
//  UIScrollViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

public extension UIScrollView {

  @discardableResult func contentOffset(_ offset: CGPoint, animated: Bool) -> Self {
    self.setContentOffset(offset, animated: animated)
    return self
  }

  /// Set zoom scale with publisher
  @discardableResult func zoomScale(
    _ scale: AnyPublisher<CGFloat, Never>,
    animated: Bool,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    scale.sink { [weak self] scale in
      self?.setZoomScale(scale, animated: animated)
    }.store(in: &cancellables)

    return self
  }

  /// Set content offset with publisher
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
}
