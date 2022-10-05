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
