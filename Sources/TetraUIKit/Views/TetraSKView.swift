//
//  TetraSKView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 09/10/2022.
//

import UIKit
import SpriteKit
import Combine

/// Wrapper of `SKView`
open class TetraSKView: SKView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraSKView, UIView?, [UIView]?) -> Void)?
}
