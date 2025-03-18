//
//  TetraUIView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UIView`
open class TetraUIView: UIView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIView, UIView?, [UIView]?) -> Void)?

  open override func addSubview(_ view: UIView) {
    super.addSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSView`
open class TetraUIView: NSView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIView, NSView?, [NSView]?) -> Void)?

  open override func addSubview(_ view: NSView) {
    super.addSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#endif
