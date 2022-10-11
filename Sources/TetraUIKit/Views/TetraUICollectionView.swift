//
//  TetraUICollectionView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

import UIKit
import Combine

/// Wrapper of `UICollectionView`
open class TetraUICollectionView: UICollectionView, TetraUISelfAdjustable {
  public var selfAdjustProcess: ((TetraUICollectionView, UIView?, [UIView]?) -> Void)?
}
