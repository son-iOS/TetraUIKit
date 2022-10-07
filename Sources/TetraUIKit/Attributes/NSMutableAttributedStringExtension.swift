//
//  NSMutableAttributedStringExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

import Foundation

public extension NSMutableAttributedString {
  /// Find [mark]s in string and apply [attributes] to the text in between those marks
  @discardableResult func formatted(
    withAttributes attributes: [NSAttributedString.Key : Any],
    betweenMark mark: String
  ) -> Self {
    let indices = string.indices(ofOccurence: mark)

    // Check if there are pairs of marks
    guard indices.count >= 2, indices.count % 2 == 0 else { return self }

    let startIndex = string.startIndex
    let lowerBound = string.index(startIndex, offsetBy: indices[0])
    let upperBound = string.index(startIndex, offsetBy: indices[1] - mark.count)

    let range = lowerBound ..< upperBound

    self.replaceCharacters(in: NSString(string: self.string).range(of: mark), with: "")
    self.replaceCharacters(in: NSString(string: self.string).range(of: mark), with: "")

    let attributesRange = NSRange(range, in: self.string)

    self.addAttributes(attributes, range: attributesRange)

    // Run again if there is another pair
    if indices.count >= 4 {
      return formatted(withAttributes: attributes, betweenMark: mark)
    }
    return self
  }
}
