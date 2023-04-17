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
    subviews(addedWithInsets: insets, useSafeArea: useSafeArea, views: children)
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
    width: Double? = nil,
    height: Double? = nil,
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
    udpateWith priorityPublihser: AnyPublisher<UILayoutPriority, Never>? = nil,
    forAxis axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentCompressionResistancePriority(priority, for: axis)
    if let view = self as? TetraUIViewCancellable {
      priorityPublihser?.sink(receiveValue: { [weak self] priority in
        self?.setContentCompressionResistancePriority(priority, for: axis)
      }).store(in: &view.viewCancellables)
    }
    return self
  }

  /// Set the [priority] for content hugging in [axis] for this view.
  @discardableResult func contentHuggingPriority(
    setTo priority: UILayoutPriority,
    udpateWith priorityPublihser: AnyPublisher<UILayoutPriority, Never>? = nil,
    forAxis axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentHuggingPriority(priority, for: axis)
    if let view = self as? TetraUIViewCancellable {
      priorityPublihser?.sink(receiveValue: { [weak self] priority in
        self?.setContentHuggingPriority(priority, for: axis)
      }).store(in: &view.viewCancellables)
    }
    return self
  }

  /// Add shadow to the this view.
  @discardableResult func shadow(
    setToColor color: UIColor,
    updateWith colorPublisher: AnyPublisher<UIColor, Never>? = nil,
    offset: CGSize,
    udpateWith offsetPublisher: AnyPublisher<CGSize, Never>? = nil,
    radius: Double,
    updateWith radiusPublisher: AnyPublisher<Double, Never>? = nil,
    opacity: Float,
    updateWith opacityPublisher: AnyPublisher<Float, Never>? = nil
  ) -> Self {
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowRadius = radius
    self.layer.shadowOpacity = opacity
    self.layer.masksToBounds = false
    self.clipsToBounds = false

    if let view = self as? TetraUIViewCancellable {
      colorPublisher?.sink(receiveValue: { [weak self] color in
        self?.layer.shadowColor = color.cgColor
      }).store(in: &view.viewCancellables)

      offsetPublisher?.sink(receiveValue: { [weak self] offset in
        self?.layer.shadowOffset = offset
      }).store(in: &view.viewCancellables)

      radiusPublisher?.sink(receiveValue: { [weak self] radius in
        self?.layer.shadowRadius = radius
      }).store(in: &view.viewCancellables)

      opacityPublisher?.sink(receiveValue: { [weak self] opacity in
        self?.layer.shadowOpacity = opacity
      }).store(in: &view.viewCancellables)
    }

    return self
  }

  /// Set the corner radius for this view.
  @discardableResult func cornerRadius(
    setTo radius: Double,
    updateWith radiusPublisher: AnyPublisher<Double, Never>? = nil,
    clipsToBounds: Bool = false,
    masksToBounds: Bool = false
  ) -> Self {
    layer.cornerRadius = radius
    self.clipsToBounds = clipsToBounds
    layer.masksToBounds = masksToBounds
    if let view = self as? TetraUIViewCancellable {
      radiusPublisher?.sink(receiveValue: { [weak self] radius in
        self?.layer.cornerRadius = radius
      }).store(in: &view.viewCancellables)
    }
    return self
  }

  /// Add a gesture recognizer to the view.
  @discardableResult func gestureRecognizerAdded(_ recognizer: UIGestureRecognizer) -> Self {
    addGestureRecognizer(recognizer)
    return self
  }

  /// Add subview and align it to this view's bounding rect. If [useSafeArea] is true, it will use the view's safe area layout guide.
  @discardableResult func subview(
    _ subview: UIView,
    addedWithInsets insets: UIEdgeInsets?,
    useSafeArea: Bool = false
  ) -> Self {
    self.subviews(addedWithInsets: insets, useSafeArea: useSafeArea) {
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
    self.subviews(insertedAtIndex: index, edWithInsets: insets, useSafeArea: useSafeArea) {
      subview
    }
  }

  /// Add subviews
  @discardableResult func subviews(
    addedWithInsets insets: UIEdgeInsets?,
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
      (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
    }

    return self
  }

  /// Insert subviews
  @discardableResult func subviews(
    insertedAtIndex index: Int,
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
      (view as? (any TetraUISelfAdjustable))?.performSelfAjustment()
    }

    return self
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

  func setAnchorPoint(_ point: CGPoint) {
    var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
    var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

    newPoint = newPoint.applying(transform)
    oldPoint = oldPoint.applying(transform)

    var position = layer.position

    position.x -= oldPoint.x
    position.x += newPoint.x

    position.y -= oldPoint.y
    position.y += newPoint.y

    layer.position = position
    layer.anchorPoint = point
  }

  func firstChildOfType<T: UIView>(_ type: T.Type) -> T? {
    if let child = subviews.first(where: { $0 is T }) {
      return child as? T
    } else {
      for subview in subviews {
        if let child = subview.firstChildOfType(T.self) {
          return child
        }
      }
      return nil
    }
  }
}
