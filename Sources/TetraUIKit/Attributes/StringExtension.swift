//
//  StringExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

import UIKit

public extension String {

  /// Calulate and returns a rect that would fit the current string with provided [font].
  func size(tofitFont font: UIFont) -> CGSize {
    return (self as NSString).size(withAttributes: [.font: font])
  }

  /// Find all the indices of a sub-string [occurrence] within this string
  func indices(ofOccurence occurrence: String) -> [Int] {
    var indices = [Int]()
    var position = startIndex

    while let range = range(of: occurrence, range: position..<endIndex) {
      let i = distance(from: startIndex, to: range.lowerBound)
      indices.append(i)

      let offset = occurrence.distance(from: occurrence.startIndex, to: occurrence.endIndex) - 1

      guard let after = index(range.lowerBound, offsetBy: offset, limitedBy: endIndex) else {
        break
      }

      position = index(after: after)
    }
    return indices
  }
}
