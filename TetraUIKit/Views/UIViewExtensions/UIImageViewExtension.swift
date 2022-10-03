//
//  UIImageView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import UIKit
import Combine

public extension UIImageView {
  /// Set the image of this image view.
  @discardableResult func image(_ image: UIImage?) -> Self {
    self.image = image
    return self
  }

  /// Set the image of this image view using publisher.
  @available(iOS 13.0, *)
  @discardableResult func image(
    _ image: AnyPublisher<UIImage?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    image.sink { [weak self] image in
      self?.image(image)
    }.store(in: &cancellables)

    return self
  }
}
