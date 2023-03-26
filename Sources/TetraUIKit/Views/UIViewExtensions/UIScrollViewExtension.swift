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
    setTo scale: Double,
    updateWith scalePublisher: AnyPublisher<Double, Never>? = nil,
    animated: Bool
  ) -> Self {
    self.setZoomScale(scale, animated: animated)
    if let view = self as? TetraUIViewCancellable {
      scalePublisher?.sink(receiveValue: { [weak self] scale in
        self?.setZoomScale(scale, animated: animated)
      }).store(in: &view.viewCancellables)
    }

    return self
  }

  /// Set content offset with publisher
  @discardableResult func contentOffset(
    setTo offset: CGPoint,
    updateWith offsetPublisher: AnyPublisher<CGPoint, Never>? = nil,
    animated: Bool,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    self.setContentOffset(offset, animated: animated)
    if let view = self as? TetraUIViewCancellable {
      offsetPublisher?.sink(receiveValue: { [weak self] offset in
        self?.setContentOffset(offset, animated: animated)
      }).store(in: &view.viewCancellables)
    }

    return self
  }
}
