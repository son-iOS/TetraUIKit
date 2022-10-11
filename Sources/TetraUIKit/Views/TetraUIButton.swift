//
//  TetraUIButton.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIButton`
open class TetraUIButton: UIButton, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUIButton, UIView?, [UIView]?) -> Void)?
}
