//
//  TetraUIScrollView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIScrollView`
open class TetraUIScrollView: UIScrollView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((UIView, UIView?, [UIView]?) -> Void)?

  /// Set the property of [keyPath] to [value]
  @discardableResult public func property<T>(
    _ keyPath: ReferenceWritableKeyPath<TetraUIScrollView, T>, setTo value: T
  ) -> Self {
    self[keyPath: keyPath] = value
    return self
  }

  /// Use [publiisher] to set the property of [keyPath]
  @discardableResult public func property<T>(
    _ keyPath: ReferenceWritableKeyPath<TetraUIScrollView, T>,
    setBy publisher: AnyPublisher<T, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    publisher.assign(to: keyPath, on: self).store(in: &cancellables)

    return self
  }
}

