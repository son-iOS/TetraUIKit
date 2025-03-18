//
//  TetraUIScrollView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UIScrollView`
open class TetraUIScrollView: UIScrollView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIScrollView, UIView?, [UIView]?) -> Void)?
  
  open override func addSubview(_ view: UIView) {
    super.addSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSScrollView`
open class TetraUIScrollView: NSScrollView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIScrollView, NSView?, [NSView]?) -> Void)?

  open override func addSubview(
    _ view: NSView,
    positioned place: NSWindow.OrderingMode = .above,
    relativeTo otherView: NSView? = nil
  ) {
    super.addSubview(view, positioned: place, relativeTo: otherView)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#endif
