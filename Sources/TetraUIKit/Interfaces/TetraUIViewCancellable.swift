//
//  TetraUIViewCancellable.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 3/26/23.
//

import Combine

#if os(iOS)

import UIKit

public protocol TetraUIViewCancellable: UIView {
  var viewCancellables: Set<AnyCancellable> { get set }
}

#elseif os(macOS)

import AppKit

public protocol TetraUIViewCancellable: NSView {
  var viewCancellables: Set<AnyCancellable> { get set }
}

#endif
