//
//  TetraUITextField.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UITextField`
open class TetraUITextField: UITextField, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUITextField, UIView?, [UIView]?) -> Void)?
}
