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
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSScrollView`
open class TetraUIScrollView: NSScrollView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIScrollView, NSView?, [NSView]?) -> Void)?
}

#endif
