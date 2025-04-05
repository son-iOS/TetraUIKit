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
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSView`
open class TetraUIView: NSView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIView, NSView?, [NSView]?) -> Void)?
}

#endif
