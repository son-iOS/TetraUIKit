//
//  TetraUIView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIView`
open class TetraUIView: UIView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIView, UIView?, [UIView]?) -> Void)?

  open override func addSubview(_ view: UIView) {
    super.addSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
    subviewsTagged()
  }
}
