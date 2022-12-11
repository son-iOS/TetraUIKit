//
//  TetraMTKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 27/11/2022.
//

import MetalKit

/// Wrapper of `MTKView`
open class TetraMTKView: MTKView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraMTKView, UIView?, [UIView]?) -> Void)?
}
