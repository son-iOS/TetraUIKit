//
//  UIScrollViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import Combine

#if os(iOS)

import UIKit

public extension UIScrollView {
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

#elseif os(macOS)

import AppKit

public extension NSScrollView {
  /// Set zoom scale with publisher
  @discardableResult func zoomScale(
    setTo scale: Double,
    updateWith scalePublisher: AnyPublisher<Double, Never>? = nil,
    animated: Bool
  ) -> Self {
    self.magnification = scale
    if let view = self as? TetraUIViewCancellable {
      scalePublisher?.sink(receiveValue: { [weak self] scale in
        self?.magnification = scale
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
    self.scroll(offset)
    if let view = self as? TetraUIViewCancellable {
      offsetPublisher?.sink(receiveValue: { [weak self] offset in
        self?.scroll(offset)
      }).store(in: &view.viewCancellables)
    }

    return self
  }
}
#endif
