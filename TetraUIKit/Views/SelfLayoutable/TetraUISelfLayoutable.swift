//
//  TetraUISelfLayoutable.swift
//  TetraUIUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import Foundation
import UIKit

/// In order to use declarative syntax with constraints, `UIView` has to be able to self layout. Implement this protocol to do that.
/// - Before start implment your self-layoutable wrapper of views from UIKit, try classes with prefix `TetraUI` (e.g.
/// `TetraUIStackView` or `TetraUIImageView`. This lib already implemented some basic views for you.
public protocol TetraUISelfLayoutable: AnyObject {
    /// The self-layout block. The arguments following the order are the view itself, its parent, and its siblings.
    var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)? { get set }
}

public extension TetraUISelfLayoutable {
    /// Add a self-layout block to the current view. The arguments following the order are the view itself, its parent, and its siblings.
    func selfLayout(_ layoutProcess: @escaping (UIView, UIView?, [UIView]?) -> Void) -> Self {
        self.selfLayoutProcess = layoutProcess
        return self
    }
}

/// Wrapper of `UIView` to make it self-autolayoutable.
open class TetraUIView: UIView, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}

/// Wrapper of `UIStackView` to make it  self-autolayoutable.
open class TetraUIStackView: UIStackView, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}

/// Wrapper of `UILabel` to make it  self-autolayoutable.
open class TetraUILabel: UILabel, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}

/// Wrapper of `UIImageView` to make it  self-autolayoutable.
open class TetraUIImageView: UIImageView, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}

/// Wrapper of `UIButton` to make it  self-autolayoutable.
open class TetraUIButton: UIButton, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}

/// Wrapper of `UITextField` to make it  self-autolayoutable.
open class TetraUITextField: UITextField, TetraUISelfLayoutable {
    public var selfLayoutProcess: ((UIView, UIView?, [UIView]?) -> Void)?
}
