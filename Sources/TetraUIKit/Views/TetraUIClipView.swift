//
//  TetraUIClipView.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 3/19/25.
//

#if os(macOS)

import AppKit
import Combine

open class TetraUIClipView: NSClipView, TetraUISelfAdjustable, TetraUIViewCancellable {
  public var viewCancellables = Set<AnyCancellable>()
  public var selfAdjustProcess: ((TetraUIClipView, NSView?, [NSView]?) -> Void)?

  open override var isFlipped: Bool {
    _flipped
  }

  private let _flipped: Bool

  public init(flipped: Bool) {
    self._flipped = flipped
    super.init(frame: .zero)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

#endif
