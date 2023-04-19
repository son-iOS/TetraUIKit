//
//  TetraUIStackView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UIStackView`
open class TetraUIStackView: UIStackView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIStackView, UIView?, [UIView]?) -> Void)?

  func addSelfAdjustableArrangedSubview(_ view: UIView) {
    super.addArrangedSubview(view)
    (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
  }
}
