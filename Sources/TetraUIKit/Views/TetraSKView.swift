//
//  TetraSKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 09/10/2022.
//

import UIKit
import SpriteKit
import Combine

/// Wrapper of `SKView`
open class TetraSKView: SKView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((UIView, UIView?, [UIView]?) -> Void)?

  /// Set the property of [keyPath] to [value]
  public func property<T>(
    _ keyPath: ReferenceWritableKeyPath<TetraSKView, T>, setTo value: T
  ) -> Self {
    self[keyPath: keyPath] = value
    return self
  }

  /// Use [publiisher] to set the property of [keyPath]
  @discardableResult public func property<T>(
    _ keyPath: ReferenceWritableKeyPath<TetraSKView, T>,
    setBy publisher: AnyPublisher<T, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    publisher.assign(to: keyPath, on: self).store(in: &cancellables)

    return self
  }
}
