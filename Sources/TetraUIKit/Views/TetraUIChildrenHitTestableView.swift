//
//  TetraUIChildrenHitTestableView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 3/18/25.
//

import CoreGraphics
import UIKit

open class TetraUIChildrenHitTestableView: TetraUIView {
  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if subviews.contains(where: { $0.point(inside: $0.convert(point, from: self), with: event) }) {
      return true
    }
    return super.point(inside: point, with: event)
  }
}

