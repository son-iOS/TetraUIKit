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
  convenience init(@TetraUIViewBuilder _ children: () -> [UIView]) {
    self.init()
    let children = children()

    for child in children {
      addSubview(child)

      if child.tag == 0 && subviews.count > 1 {
        child.tag = subviews.count - 1
      }
    }

    for child in children where child is TetraUISelfLayoutable {
      (child as? TetraUISelfLayoutable)?.selfLayoutProcess?(child, self, subviews)
    }
  }

  /// Load a view from nib by [name] in [bundle].
  static func loadFrom<T: UIView>(nibNamed name: String, bundle : Bundle? = nil) -> T? {
    let nib = UINib(nibName: name, bundle: bundle)
    return nib.instantiate(withOwner: nil, options: nil)[0] as? T
  }

  /// Create a separator view filled with [color]. It can be a vertical line or horizontal line based on [axis].
  /// If axis is horizontal, you'll have to supply [height], same with [width] when used for veritcal axis.
  /// You can also specify [insets] for the separator.
  static func separatorView(axis: NSLayoutConstraint.Axis,
                            color: UIColor? = .lightGray,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil,
                            insets: UIEdgeInsets? = nil) -> UIView {
    let result = UIView()
    if axis == .horizontal, let height = height {
      result.dimension(.height, setTo: height)
      if width == nil, insets == nil {
        result.backgroundColor(color)
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
          result.addSubview(separator, withInsets: insets)
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
          .backgroundColor(color)
        if let height = height {
          result.addSubview(separator)
          separator
            .dimension(.height, setTo: height)
            .centered(in: result)
        } else if let insets = insets {
          result.addSubview(separator, withInsets: insets)
        }
      }
    }

    return result
  }

  /// Create a spacer view to use in stack view. Spacer view will expand and fill all the avaiable space and pushes the other
  /// siblings to the other side of the their parent stack view.
  static func spacerView() -> UIView {
    let result = UIView()
    result.setContentCompressionResistancePriority(.required, for: .horizontal)
    result.setContentCompressionResistancePriority(.required, for: .vertical)
    return result
  }

  /// Add a int [tag] to this view.
  @discardableResult func tag(
    _ tag: Int
  ) -> Self {
    self.tag = tag
    return self
  }

  /// Set the [priority] for content compression resistance in [axis] for this view.
  @discardableResult func contentCompressionResistancePriority(
    _ priority: UILayoutPriority,
    for axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentCompressionResistancePriority(priority, for: axis)
    return self
  }

  /// Set the content compression resistance priority using publisher [priority] in [axis] for this view.
  /// Cancellable is stored in [cancellables].
  @discardableResult func contentCompressionResistancePriority(
    _ priority: AnyPublisher<UILayoutPriority, Never>,
    for axis: NSLayoutConstraint.Axis,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    priority.sink { [weak self] priority in
      self?.contentCompressionResistancePriority(priority, for: axis)
    }.store(in: &cancellables)

    return self
  }

  /// Set the [priority] for content hugging in [axis] for this view.
  @discardableResult func contentHuggingPriority(
    _ priority: UILayoutPriority,
    for axis: NSLayoutConstraint.Axis
  ) -> Self {
    self.setContentHuggingPriority(priority, for: axis)
    return self
  }

  /// Set the content hugging priority using publisher [priority] in [axis] for this view.
  /// Cancellable is stored in [cancellables].
  @discardableResult func contentHuggingPriority(
    _ priority: AnyPublisher<UILayoutPriority, Never>,
    for axis: NSLayoutConstraint.Axis,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    priority.sink { [weak self] priority in
      self?.contentHuggingPriority(priority, for: axis)
    }.store(in: &cancellables)

    return self
  }

  /// Add shadow to the this view.
  @discardableResult func shadow(color: UIColor,
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
    color: AnyPublisher<UIColor, Never>,
    offset: AnyPublisher<CGSize, Never>,
    radius: AnyPublisher<CGFloat, Never>,
    opacity: AnyPublisher<Float, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    self.layer.masksToBounds = false
    self.clipsToBounds = false
    Publishers.CombineLatest4(color, offset, radius, opacity)
      .sink { [weak self] color, offset, radius, opacity in
        self?.shadow(color: color, offset: offset, radius: radius, opacity: opacity)
      }.store(in: &cancellables)

    return self
  }

  /// Set the corner radius for this view.
  @discardableResult func cornerRadius(_ radius: CGFloat) -> Self {
    layer.cornerRadius = radius
    clipsToBounds = true
    layer.masksToBounds = true
    return self
  }

  /// Set the corner radius for this view using publisher.
  @discardableResult func cornerRadius(
    _ radius: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    radius.sink { [weak self] radius in
      self?.cornerRadius(radius)
    }.store(in: &cancellables)

    return self
  }

  /// Set the opacity for this view.
  @discardableResult func alpha(_ alpha: CGFloat) -> Self {
    self.alpha = alpha
    return self
  }

  /// Set the opacity for this view using publisher.
  @discardableResult func alpha(
    _ alpha: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    alpha.sink { [weak self] alpha in
      self?.alpha(alpha)
    }.store(in: &cancellables)

    return self
  }

  /// Set the visibility for this view.
  @discardableResult func isVisible(_ isVisible: Bool) -> Self {
    self.isVisible = isVisible
    return self
  }

  /// Set the visibility for this view using publisher.
  @discardableResult func isVisible(
    _ isVisible: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    isVisible.sink { [weak self] isVisible in
      self?.isVisible(isVisible)
    }.store(in: &cancellables)

    return self
  }

  /// Add background color to view.
  @discardableResult func backgroundColor(_ color: UIColor?) -> Self {
    backgroundColor = color
    return self
  }

  /// Set the background color for this view using publisher.
  @discardableResult func backgroundColor(
    _ color: AnyPublisher<UIColor?, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    color.sink { [weak self] color in
      self?.backgroundColor(color)
    }.store(in: &cancellables)

    return self
  }

  /// Add tint color to view.
  @discardableResult func tintColor(_ color: UIColor) -> Self {
    tintColor = color
    return self
  }

  /// Set the tint color for this view using publisher.
  @discardableResult func tintColor(
    _ color: AnyPublisher<UIColor, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    color.sink { [weak self] color in
      self?.tintColor(color)
    }.store(in: &cancellables)

    return self
  }

  /// Set the content mode for this view.
  @discardableResult func contentMode(_ contentMode: ContentMode) -> Self {
    self.contentMode = contentMode
    return self
  }

  /// Set the content mode for this view using publisher.
  @discardableResult func contentMode(
    _ mode: AnyPublisher<ContentMode, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    mode.sink { [weak self] mode in
      self?.contentMode(mode)
    }.store(in: &cancellables)

    return self
  }

  /// Add subview and align it to this view's safe area.
  @discardableResult func addSubview(_ subview: UIView,
                                     withSafeAreaInsets insets: UIEdgeInsets) -> Self {
    self.addSubview(subview)
    subview.edgesPinnedToEdges(of: self, with: insets, useSafeArea: true)

    return self
  }

  /// Add subview and align it to this view's bounding rect.
  @discardableResult func addSubview(_ subview: UIView, withInsets insets: UIEdgeInsets) -> Self {
    self.addSubview(subview)
    subview.edgesPinnedToEdges(of: self, with: insets)

    return self
  }

  /// Add the scroll view as a subview and pin its frame layout guide to this view's bounds.
  @discardableResult func addScrollView(_ scrollView: UIScrollView) -> Self {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(scrollView)

    return self
      .constraintType(.leading, constrainedTo: .leading, of: scrollView.frameLayoutGuide)
      .constraintType(.trailing, constrainedTo: .trailing, of: scrollView.frameLayoutGuide)
      .constraintType(.top, constrainedTo: .top, of: scrollView.frameLayoutGuide)
      .constraintType(.bottom, constrainedTo: .bottom, of: scrollView.frameLayoutGuide)
  }

  /// Insert a subview and align it with this view's safe area.
  @discardableResult func insertSubview(_ subview: UIView,
                                        at index: Int,
                                        withSafeAreaInsets insets: UIEdgeInsets) -> Self {
    self.insertSubview(subview, at: index)
    subview.edgesPinnedToEdges(of: self, with: insets, useSafeArea: true)

    return self
  }

  /// Insert a subview and align it with this view's bounds.
  @discardableResult func insertSubview(_ subview: UIView,
                                        at index: Int,
                                        withInsets insets: UIEdgeInsets) -> Self {
    self.insertSubview(subview, at: index)
    subview.edgesPinnedToEdges(of: self, with: insets)

    return self
  }

  /// Add the scroll view as a subview and pin its frame layout guide to this view's bounds.
  @discardableResult func insertScrollView(_ scrollView: UIScrollView, at index: Int) -> Self {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.insertSubview(scrollView, at: index)

    return self
      .constraintType(.leading, constrainedTo: .leading, of: scrollView.frameLayoutGuide)
      .constraintType(.trailing, constrainedTo: .trailing, of: scrollView.frameLayoutGuide)
      .constraintType(.top, constrainedTo: .top, of: scrollView.frameLayoutGuide)
      .constraintType(.bottom, constrainedTo: .bottom, of: scrollView.frameLayoutGuide)
  }
  
  /// Assign this view to a property.
  @discardableResult func assign<T>(to property: inout T) -> Self {
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
}
