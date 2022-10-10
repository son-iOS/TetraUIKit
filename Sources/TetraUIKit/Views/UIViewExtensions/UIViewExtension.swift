//
//  UIViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 1/10/22.
//

import UIKit
import Combine

public extension UIView {

  /// Create a view with specified [children]. Children will be tagged with the order within the array.
  convenience init(
    @TetraUIViewBuilder children: () -> [UIView],
    withInsets insets: UIEdgeInsets? = nil,
    useSafeArea: Bool = false
  ) {
    self.init()
    subviewsAdded(withInsets: insets, useSafeArea: useSafeArea, views: children)
  }

  /// Load a view from nib by [name] in [bundle].
  static func loadedFrom<T: UIView>(nibNamed name: String, bundle : Bundle? = nil) -> T? {
    let nib = UINib(nibName: name, bundle: bundle)
    return nib.instantiate(withOwner: nil, options: nil)[0] as? T
  }

  /// Create a separator view filled with [color]. It can be a vertical line or horizontal line based on [axis].
  /// If axis is horizontal, you'll have to supply [height], same with [width] when used for veritcal axis.
  /// You can also specify [insets] for the separator.
  static func separatorView(
    axis: NSLayoutConstraint.Axis,
    color: UIColor? = .lightGray,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    insets: UIEdgeInsets? = nil
  ) -> UIView {
    let result = UIView()
    if axis == .horizontal, let height = height {
      result.dimension(.height, setTo: height)
      if width == nil, insets == nil {
        result.backgroundColor = color
      } else {
        let separator = UIView()
        separator
          .dimension(.height, setTo: height)
          .backgroundColor = color
        if let width = width {
          result.addSubview(separator)
          separator
            .dimension(.width, setTo: width)
            .centered(in: separator.superview)
        } else if let insets = insets {
          result.subview(separator, addedWithInsets: insets)
        }
      }
    } else if axis == .vertical, let width = width {
      result.dimension(.width, setTo: width)
      if height == nil, insets == nil {
        result.backgroundColor = color
      } else {
        let separator = UIView()
        separator
          .dimension(.width, setTo: width)
          .backgroundColor = color
        if let height = height {
          result.addSubview(separator)
          separator
            .dimension(.height, setTo: height)
            .centered(in: result)
        } else if let insets = insets {
          result.subview(separator, addedWithInsets: insets)
        }
      }
    }

    return result
  }

  /// Create a spacer view to use in stack view. Spacer view will expand and fill all the avaiable space and pushes the other
  /// siblings to the other side of the their parent stack view.
  static func spacerView() -> TetraUIView {
    let result = TetraUIView()
    result.setContentCompressionResistancePriority(.required, for: .horizontal)
    result.setContentCompressionResistancePriority(.required, for: .vertical)
    return result
  }

  /// Set the [priority] for content compression resistance in [axis] for this view.
  @discardableResult func contentCompressionResistancePriority(
    setTo priority: UILayoutPriority,
    forAxis axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentCompressionResistancePriority(priority, for: axis)
    return self
  }

  /// Set the content compression resistance priority using publisher [priority] in [axis] for this view.
  /// Cancellable is stored in [cancellables].
  @discardableResult func contentCompressionResistancePriority(
    setBy priority: AnyPublisher<UILayoutPriority, Never>,
    forAxis axis: NSLayoutConstraint.Axis,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    priority.sink { [weak self] priority in
      self?.contentCompressionResistancePriority(setTo: priority, forAxis: axis)
    }.store(in: &cancellables)

    return self
  }

  /// Set the [priority] for content hugging in [axis] for this view.
  @discardableResult func contentHuggingPriority(
    setTo priority: UILayoutPriority,
    forAxis axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentHuggingPriority(priority, for: axis)
    return self
  }

  /// Set the content hugging priority using publisher [priority] in [axis] for this view.
  /// Cancellable is stored in [cancellables].
  @discardableResult func contentHuggingPriority(
    setBy priority: AnyPublisher<UILayoutPriority, Never>,
    forAxis axis: NSLayoutConstraint.Axis,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    priority.sink { [weak self] priority in
      self?.contentHuggingPriority(setTo: priority, forAxis: axis)
    }.store(in: &cancellables)

    return self
  }

  /// Add shadow to the this view.
  @discardableResult func shadow(setToColor color: UIColor,
                                 offset: CGSize,
                                 radius: CGFloat,
                                 opacity: Float) -> Self {
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowRadius = radius
    self.layer.shadowOpacity = opacity
    self.layer.masksToBounds = false
    self.clipsToBounds = false

    return self
  }

  /// Add shadow to the this view using publishers.
  @discardableResult func shadow(
    setByColor color: AnyPublisher<UIColor, Never>,
    offset: AnyPublisher<CGSize, Never>,
    radius: AnyPublisher<CGFloat, Never>,
    opacity: AnyPublisher<Float, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    self.layer.masksToBounds = false
    self.clipsToBounds = false
    Publishers.CombineLatest4(color, offset, radius, opacity)
      .sink { [weak self] color, offset, radius, opacity in
        self?.shadow(setToColor: color, offset: offset, radius: radius, opacity: opacity)
      }.store(in: &cancellables)

    return self
  }

  /// Set the corner radius for this view.
  @discardableResult func cornerRadius(
    setTo radius: CGFloat,
    clipsToBounds: Bool = false,
    masksToBounds: Bool = false) -> Self {
    layer.cornerRadius = radius
    self.clipsToBounds = clipsToBounds
    layer.masksToBounds = masksToBounds
    return self
  }

  /// Set the corner radius for this view using publisher.
  @discardableResult func cornerRadius(
    setByRadius radius: AnyPublisher<CGFloat, Never>,
    clipsToBounds: Bool = true,
    masksToBounds: Bool = false,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    radius.sink { [weak self] radius in
      self?.cornerRadius(setTo: radius, clipsToBounds: clipsToBounds, masksToBounds: masksToBounds)
    }.store(in: &cancellables)

    return self
  }

  /// Add subview and align it to this view's bounding rect. If [useSafeArea] is true, it will use the view's safe area layout guide.
  @discardableResult func subview(
    _ subview: UIView,
    addedWithInsets insets: UIEdgeInsets?,
    useSafeArea: Bool = false
  ) -> Self {
    self.subviewsAdded(withInsets: insets, useSafeArea: useSafeArea) {
      subview
    }
  }

  /// Insert a subview and align it with this view's bounds. If [useSafeArea] is true, it will use the view's safe area layout guide.
  @discardableResult func subview(
    _ subview: UIView,
    insertedAt index: Int,
    withInsets insets: UIEdgeInsets?,
    useSafeArea: Bool = false
  ) -> Self {
    self.subviewsInserted(at: index, edWithInsets: insets, useSafeArea: useSafeArea) {
      subview
    }
  }

  /// Add subviews
  @discardableResult func subviewsAdded(
    withInsets insets: UIEdgeInsets?,
    useSafeArea: Bool = false,
    @TetraUIViewBuilder views: () -> [UIView]
  ) -> Self {
    let views = views()
    for view in views {
      addSubview(view)
      if let insets = insets {
        view.edgesPinnedToEdges(of: self, withInset: insets, useSafeArea: useSafeArea)
      }
    }
    for view in views {
      view.performSelfAjustment()
    }

    return self.subviewsTagged()
  }

  /// Insert subviews
  @discardableResult func subviewsInserted(
    at index: Int,
    edWithInsets insets: UIEdgeInsets?,
    useSafeArea: Bool = false,
    @TetraUIViewBuilder views: () -> [UIView]
  ) -> Self {
    guard index <= subviews.count else { return self }

    let views = views()
    for (i, view) in views.enumerated() {
      insertSubview(view, at: index + i)
      if let insets = insets {
        view.edgesPinnedToEdges(of: self, withInset: insets, useSafeArea: useSafeArea)
      }
    }
    for view in views {
      view.performSelfAjustment()
    }

    return self.subviewsTagged()
  }
  
  /// Assign this view to a property.
  @discardableResult func assigned<T>(to property: inout T?) -> Self {
    guard let view = self as? T else {
      fatalError("Mismatching types for assignment")
    }

    property = view
    return self
  }

  /// Convinient property to work with instead of isHidden
  var isVisible: Bool {
    get { !isHidden }
    set {
      if isHidden != !newValue {
        isHidden = !newValue
      }
    }
  }

  /// Perform self adjustment if possible
  internal func performSelfAjustment() {
    guard let selfAdjustable = self as? TetraUISelfAdjustable else { return }
    selfAdjustable.selfAdjustProcess?(self, self.superview, self.superview?.subviews)
    selfAdjustable.selfAdjustProcess = nil
  }

  /// Perform tagging on subviews
  @discardableResult internal func subviewsTagged() -> Self {
    guard subviews.count > 1 else { return self }
    for (index, subview) in subviews[1..<subviews.count].enumerated() {
      subview.tag = subview.tag == 0 ? index : subview.tag
    }

    return self
  }
}
