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
open class TetraSKView: SKView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraSKView, UIView?, [UIView]?) -> Void)?
}
