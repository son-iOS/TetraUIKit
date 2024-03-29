//
//  TetraUIButton.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIButton`
open class TetraUIButton: UIButton, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIButton, UIView?, [UIView]?) -> Void)?
}
