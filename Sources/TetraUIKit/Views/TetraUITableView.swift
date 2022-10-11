//
//  TetraUITableView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UITableView`
open class TetraUITableView: UITableView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUITableView, UIView?, [UIView]?) -> Void)?
}
