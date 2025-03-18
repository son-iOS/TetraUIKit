//
//  TetraUIButton.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UIButton`
open class TetraUIButton: UIButton, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIButton, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `UIButton`
open class TetraUIButton: NSButton, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIButton, NSView?, [NSView]?) -> Void)?
}

#endif
