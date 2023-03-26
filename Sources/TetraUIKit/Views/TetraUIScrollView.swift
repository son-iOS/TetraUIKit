//
//  TetraUIScrollView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIScrollView`
open class TetraUIScrollView: UIScrollView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIScrollView, UIView?, [UIView]?) -> Void)?
  
  open override func addSubview(_ view: UIView) {
    super.addSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
    subviewsTagged()
  }
}

