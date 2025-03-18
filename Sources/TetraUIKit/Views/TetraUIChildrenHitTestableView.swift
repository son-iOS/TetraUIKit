//
//  TetraUIChildrenHitTestableView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 3/18/25.
//

import CoreGraphics

#if os(iOS)

import UIKit

open class TetraUIChildrenHitTestableView: TetraUIView {
  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    if subviews.contains(where: { $0.point(inside: $0.convert(point, from: self), with: event) }) {
      return true
    }
    return super.point(inside: point, with: event)
  }
}

#elseif os(macOS)

import AppKit

open class TetraUIChildrenHitTestableView: TetraUIView {
  open override func isMousePoint(_ point: NSPoint, in rect: NSRect) -> Bool {
    if subviews.contains(where: { $0.isMousePoint($0.convert(point, from: self), in: rect) }) {
      true
    } else {
      super.isMousePoint(point, in: rect)
    }
  }
}

#endif
