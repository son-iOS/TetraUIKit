//
//  TetraSKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 09/10/2022.
//

import SpriteKit
import Combine

#if os(iOS)

import UIKit

/// Wrapper of `SKView`
open class TetraSKView: SKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraSKView, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `SKView`
open class TetraSKView: SKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraSKView, NSView?, [NSView]?) -> Void)?
}

#endif
