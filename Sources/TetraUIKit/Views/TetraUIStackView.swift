//
//  TetraUIStackView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UIStackView`
open class TetraUIStackView: UIStackView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIStackView, UIView?, [UIView]?) -> Void)?

  func addSelfAdjustableArrangedSubview(_ view: UIView) {
    super.addArrangedSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSStackView`
open class TetraUIStackView: NSStackView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIStackView, NSView?, [NSView]?) -> Void)?

  func addSelfAdjustableArrangedSubview(_ view: NSView) {
    super.addArrangedSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}

#endif
