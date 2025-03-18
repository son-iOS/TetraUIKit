//
//  TetraMTKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 27/11/2022.
//

import MetalKit
import Combine

#if os(iOS)

import UIKit

/// Wrapper of `MTKView`
open class TetraMTKView: MTKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraMTKView, UIView?, [UIView]?) -> Void)?
}

#elseif os(macOS)

import AppKit

/// Wrapper of `MTKView`
open class TetraMTKView: MTKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraMTKView, NSView?, [NSView]?) -> Void)?
}

#endif
