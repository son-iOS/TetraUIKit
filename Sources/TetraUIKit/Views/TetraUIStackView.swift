//
//  TetraUIStackView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIStackView`
open class TetraUIStackView: UIStackView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUIStackView, UIView?, [UIView]?) -> Void)?

  open override func addArrangedSubview(_ view: UIView) {
    super.addArrangedSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
    subviewsTagged()
  }
}
