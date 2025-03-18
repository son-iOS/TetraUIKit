//
//  TetraUITableView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import Combine

#if os(iOS)

import UIKit

/// Wrapper of `UITableView`
open class TetraUITableView: UITableView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUITableView, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `NSTableView`
open class TetraUITableView: NSTableView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUITableView, NSView?, [NSView]?) -> Void)?
}

#endif
