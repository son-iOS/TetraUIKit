//
//  TetraUITextView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UITextView`
open class TetraUITextView: UITextView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUITextView, UIView?, [UIView]?) -> Void)?
}
