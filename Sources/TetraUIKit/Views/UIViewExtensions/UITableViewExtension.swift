//
//  UITableViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 05/10/2022.
//

#if os(iOS)

import UIKit

public extension UITableView {
  func delegate(_ delegate: UITableViewDelegate?) -> Self {
    self.delegate = delegate

    return self
  }

  func dataSource(_ dataSource: UITableViewDataSource?) -> Self {
    self.dataSource = dataSource

    return self
  }

  func cell(_ cellClass: AnyClass?, registeredWithId id: String) -> Self {
    self.register(cellClass, forCellReuseIdentifier: id)

    return self
  }

  func headerFooter(_ aClass: AnyClass?, registeredWithId id: String) -> Self {
    self.register(aClass, forHeaderFooterViewReuseIdentifier: id)

    return self 
  }
}

#endif
