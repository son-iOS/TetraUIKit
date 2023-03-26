//
//  TetraUILabel.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UILabel`
open class TetraUILabel: UILabel, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUILabel, UIView?, [UIView]?) -> Void)?
}
