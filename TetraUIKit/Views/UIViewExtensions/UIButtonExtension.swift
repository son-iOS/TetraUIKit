//
//  UIButtonExtension.swift
//  DeclarativeUIKit
//
//  Created by Son Nguyen on 1/11/22.
//

import Foundation
import UIKit
import Combine

public extension UIButton {
    
    /// Set the title for this button.
    @discardableResult func title(_ title: String?, for state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    /// Set the title for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func title(
        _ title: AnyPublisher<String?, Never>,
        for state: UIControl.State,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        title.sink { [weak self] title in
            self?.title(title, for: state)
        }.store(in: &cancellables)
        
        return self
    }
    
    /// Set the image for this button.
    @discardableResult func image(_ image: UIImage?, for state: UIControl.State) -> Self {
        self.setImage(image, for: state)
        return self
    }
    
    /// Set the image for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func image(
        _ image: AnyPublisher<UIImage?, Never>,
        for state: UIControl.State,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        image.sink { [weak self] image in
            self?.image(image, for: state)
        }.store(in: &cancellables)
        
        return self
    }
    
    /// Set the state of this button.
    @discardableResult func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    /// Set the state for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func isEnabled(
        _ isEnabled: AnyPublisher<Bool, Never>,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        isEnabled.sink { [weak self] isEnabled in
            self?.isEnabled(isEnabled)
        }.store(in: &cancellables)
        
        return self
    }
    
    /// Set the title color for this button.
    @discardableResult func titleColor(_ color: UIColor?, for state: UIControl.State) -> Self {
        self.setTitleColor(color, for: state)
        return self
    }
    
    /// Set the title color for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func titleColor(
        _ color: AnyPublisher<UIColor?, Never>,
        for state: UIControl.State,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        color.sink { [weak self] color in
            self?.titleColor(color, for: state)
        }.store(in: &cancellables)
        
        return self
    }
    
    /// Set the font for this button.
    @discardableResult func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    /// Set the font for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func font(
        _ font: AnyPublisher<UIFont, Never>,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        font.sink { [weak self] font in
            self?.font(font)
        }.store(in: &cancellables)
        
        return self
    }
    
    /// Set the action for this button.
    @discardableResult func target(_ target: Any?,
                                   action: Selector,
                                   for controlEvents: UIControl.Event) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    /// Set the action for this button using publisher.
    @available(iOS 13.0, *)
    @discardableResult func target(
        _ target: Any?,
        action: AnyPublisher<Selector, Never>,
        for controlEvents: UIControl.Event,
        cancelledWith cancellables: inout Set<AnyCancellable>
    ) -> Self {
        if let target = target as AnyObject? {
            action.sink { [weak self, weak target] action in
                self?.target(target, action: action, for: controlEvents)
            }.store(in: &cancellables)
        } else {
            action.sink { [weak self] action in
                self?.target(target, action: action, for: controlEvents)
            }.store(in: &cancellables)
        }
        
        return self
    }
}
