//
//  TetraUIImageView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UIImageView`
open class TetraUIImageView: UIImageView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIImageView, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSImageView`
open class TetraUIImageView: NSImageView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIImageView, NSView?, [NSView]?) -> Void)?
}

#endif
