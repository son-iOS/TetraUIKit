//
//  TetraUITextView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UITextView`
open class TetraUITextView: UITextView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUITextView, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSTextView`
open class TetraUITextView: NSTextView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUITextView, NSView?, [NSView]?) -> Void)?
}

#endif
