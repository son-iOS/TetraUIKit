//
//  UIScrollViewExtension.swift
//  TetraUIKit
//
//  Created by Son Nguyen on 04/10/2022.
//

import UIKit
import Combine

public extension UIScrollView {
  @discardableResult func contentSize(_ size: CGSize) -> Self {
    self.contentSize = size
    return self
  }

  @discardableResult func contentSize(
    _ size: AnyPublisher<CGSize, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    size.sink { [weak self] size in
      self?.contentSize = size
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func contentOffset(_ offset: CGPoint, animated: Bool) -> Self {
    self.setContentOffset(offset, animated: animated)
    return self
  }

  @discardableResult func contentOffset(
    _ offset: AnyPublisher<CGPoint, Never>,
    animated: Bool,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    offset.sink { [weak self] offset in
      self?.setContentOffset(offset, animated: animated)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func contentInset(_ inset: UIEdgeInsets) -> Self {
    self.contentInset = inset
    return self
  }

  @discardableResult func contentInset(
    _ inset: AnyPublisher<UIEdgeInsets, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    inset.sink { [weak self] inset in
      self?.contentInset = inset
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func contentInsetAdjustmentBehavior(
    _ contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior
  ) -> Self {
    self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
    return self
  }

  @discardableResult func contentInsetAdjustmentBehavior(
    _ contentInsetAdjustmentBehavior: AnyPublisher<UIScrollView.ContentInsetAdjustmentBehavior, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    contentInsetAdjustmentBehavior.sink { [weak self] contentInsetAdjustmentBehavior in
      self?.contentInsetAdjustmentBehavior(contentInsetAdjustmentBehavior)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func isScrollEnabled(_ enabled: Bool) -> Self {
    self.isScrollEnabled = enabled
    return self
  }

  @discardableResult func isScrollEnabled(
    _ enabled: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    enabled.sink { [weak self] enabled in
      self?.isScrollEnabled(enabled)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func isDirectionalLockEnabled(_ enabled: Bool) -> Self {
    self.isDirectionalLockEnabled = enabled
    return self
  }

  @discardableResult func isDirectionalLockEnabled(
    _ enabled: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    enabled.sink { [weak self] enabled in
      self?.isDirectionalLockEnabled(enabled)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func isPagingEnabled(_ enabled: Bool) -> Self {
    self.isPagingEnabled = enabled
    return self
  }

  @discardableResult func isPagingEnabled(
    _ enabled: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    enabled.sink { [weak self] enabled in
      self?.isPagingEnabled(enabled)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func scrollsToTop(_ toTop: Bool) -> Self {
    self.scrollsToTop = toTop
    return self
  }

  @discardableResult func scrollsToTop(
    _ toTop: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    toTop.sink { [weak self] toTop in
      self?.scrollsToTop(toTop)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func bounces(_ bounces: Bool) -> Self {
    self.bounces = bounces
    return self
  }

  @discardableResult func bounces(
    _ bounces: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    bounces.sink { [weak self] bounces in
      self?.bounces(bounces)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func alwaysBounceVertical(_ verticalBounces: Bool) -> Self {
    self.alwaysBounceVertical = verticalBounces
    return self
  }

  @discardableResult func alwaysBounceVertical(
    _ verticalBounces: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    verticalBounces.sink { [weak self] verticalBounces in
      self?.alwaysBounceVertical(verticalBounces)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func alwaysBounceHorizontal(_ horizontalBounces: Bool) -> Self {
    self.alwaysBounceHorizontal = horizontalBounces
    return self
  }

  @discardableResult func alwaysBounceHorizontal(
    _ horizontalBounces: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    horizontalBounces.sink { [weak self] horizontalBounces in
      self?.alwaysBounceHorizontal(horizontalBounces)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
    self.indicatorStyle = style
    return self
  }

  @discardableResult func indicatorStyle(
    _ style: AnyPublisher<UIScrollView.IndicatorStyle, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    style.sink { [weak self] style in
      self?.indicatorStyle(style)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func showsHorizontalScrollIndicator(_ shouldShow: Bool) -> Self {
    self.showsHorizontalScrollIndicator = shouldShow
    return self
  }

  @discardableResult func showsHorizontalScrollIndicator(
    _ shouldShow: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    shouldShow.sink { [weak self] shouldShow in
      self?.showsHorizontalScrollIndicator(shouldShow)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func showsVerticalScrollIndicator(_ shouldShow: Bool) -> Self {
    self.showsVerticalScrollIndicator = shouldShow
    return self
  }

  @discardableResult func showsVerticalScrollIndicator(
    _ shouldShow: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    shouldShow.sink { [weak self] shouldShow in
      self?.showsVerticalScrollIndicator(shouldShow)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func horizontalScrollIndicatorInsets(_ inset: UIEdgeInsets) -> Self {
    self.horizontalScrollIndicatorInsets = inset
    return self
  }

  @discardableResult func horizontalScrollIndicatorInsets(
    _ inset: AnyPublisher<UIEdgeInsets, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    inset.sink { [weak self] inset in
      self?.horizontalScrollIndicatorInsets(inset)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func verticalScrollIndicatorInsets(_ inset: UIEdgeInsets) -> Self {
    self.verticalScrollIndicatorInsets = inset
    return self
  }

  @discardableResult func verticalScrollIndicatorInsets(
    _ inset: AnyPublisher<UIEdgeInsets, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    inset.sink { [weak self] inset in
      self?.verticalScrollIndicatorInsets(inset)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func automaticallyAdjustsScrollIndicatorInsets(_ automated: Bool) -> Self {
    self.automaticallyAdjustsScrollIndicatorInsets = automated
    return self
  }

  @discardableResult func automaticallyAdjustsScrollIndicatorInsets(
    _ automated: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    automated.sink { [weak self] automated in
      self?.automaticallyAdjustsScrollIndicatorInsets(automated)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func refreshControl(_ refresh: UIRefreshControl) -> Self {
    self.refreshControl = refresh
    return self
  }

  @discardableResult func refreshControl(
    _ refresh: AnyPublisher<UIRefreshControl, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    refresh.sink { [weak self] refresh in
      self?.refreshControl(refresh)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func canCancelContentTouches(_ canCancel: Bool) -> Self {
    self.canCancelContentTouches = canCancel
    return self
  }

  @discardableResult func canCancelContentTouches(
    _ canCancel: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    canCancel.sink { [weak self] canCancel in
      self?.canCancelContentTouches(canCancel)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func delaysContentTouches(_ delayTouches: Bool) -> Self {
    self.delaysContentTouches = delayTouches
    return self
  }

  @discardableResult func delaysContentTouches(
    _ delayTouches: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    delayTouches.sink { [weak self] delayTouches in
      self?.delaysContentTouches(delayTouches)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func zoomScale(_ scale: CGFloat) -> Self {
    self.zoomScale = scale
    return self
  }

  @discardableResult func zoomScale(
    _ scale: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    scale.sink { [weak self] scale in
      self?.zoomScale(scale)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func maximumZoomScale(_ scale: CGFloat) -> Self {
    self.maximumZoomScale = scale
    return self
  }

  @discardableResult func maximumZoomScale(
    _ scale: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    scale.sink { [weak self] scale in
      self?.maximumZoomScale(scale)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func minimumZoomScale(_ scale: CGFloat) -> Self {
    self.minimumZoomScale = scale
    return self
  }

  @discardableResult func minimumZoomScale(
    _ scale: AnyPublisher<CGFloat, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    scale.sink { [weak self] scale in
      self?.minimumZoomScale(scale)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func bouncesZoom(_ bounces: Bool) -> Self {
    self.bouncesZoom = bounces
    return self
  }

  @discardableResult func bouncesZoom(
    _ bounces: AnyPublisher<Bool, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    bounces.sink { [weak self] bounces in
      self?.bouncesZoom(bounces)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
    self.keyboardDismissMode = mode
    return self
  }

  @discardableResult func keyboardDismissMode(
    _ mode: AnyPublisher<UIScrollView.KeyboardDismissMode, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    mode.sink { [weak self] mode in
      self?.keyboardDismissMode(mode)
    }.store(in: &cancellables)

    return self
  }

  @discardableResult func indexDisplayMode(_ mode: UIScrollView.IndexDisplayMode) -> Self {
    self.indexDisplayMode = mode
    return self
  }

  @discardableResult func indexDisplayMode(
    _ mode: AnyPublisher<UIScrollView.IndexDisplayMode, Never>,
    cancelledWith cancellables: inout Set<AnyCancellable>
  ) -> Self {
    mode.sink { [weak self] mode in
      self?.indexDisplayMode(mode)
    }.store(in: &cancellables)

    return self
  }

  /// Set the delegate for this scroll view.
  @discardableResult func delegate(_ delegate: UIScrollViewDelegate?) -> Self {
    self.delegate = delegate
    return self
  }
}
