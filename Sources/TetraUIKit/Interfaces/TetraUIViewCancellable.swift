//
//  TetraUIViewCancellable.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 3/26/23.
//

import UIKit
import Combine

public protocol TetraUIViewCancellable: UIView {
  var viewCancellables: Set<AnyCancellable> { get set }
}
