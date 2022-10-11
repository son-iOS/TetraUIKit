//
//  TetraUIImageView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIImageView`
open class TetraUIImageView: UIImageView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUIImageView, UIView?, [UIView]?) -> Void)?
}
