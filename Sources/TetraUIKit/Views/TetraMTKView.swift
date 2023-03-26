//
//  TetraMTKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 27/11/2022.
//

import MetalKit
import Combine

/// Wrapper of `MTKView`
open class TetraMTKView: MTKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraMTKView, UIView?, [UIView]?) -> Void)?
}
