//
//  KeyboardHandler.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KeyboardHandler {
    
    private init() {}
    
    struct PresentingParams {
        let keyboardSize: CGSize
        let animationDuration: Double
        let state: State
        enum State {
            case show
            case hide
        }
    }
    
    enum Insets {
        case forShown(inset: CGFloat)
        case forHidden(inset: CGFloat)
        case always(inset: CGFloat)
        case never
        
        func add(to value: CGFloat, with state: PresentingParams.State) -> CGFloat {
            switch (self, state) {
            case (.always(let inset), _):
                return value + inset
            case (.forShown(let inset), .show):
                return value + inset
            case (.forHidden(let inset), .hide):
                return value + inset
            default:
                return value
            }
        }
    }
    
}

extension KeyboardHandler {
    
    static private(set) var keyboardPresenting: Observable<PresentingParams> = {
        
        let show = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map { (notification) -> PresentingParams? in
            guard let userInfo = notification.userInfo,
                let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                let animationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber)?.doubleValue
            else { return nil }
            return PresentingParams(
                keyboardSize: keyboardSize.size,
                animationDuration: animationDuration,
                state: .show
            )
        }
        
        let hide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map { (notification) -> PresentingParams? in
            guard let userInfo = notification.userInfo,
                let animationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber)?.doubleValue
            else { return nil }
            return PresentingParams(
                keyboardSize: CGSize.zero,
                animationDuration: animationDuration,
                state: .hide
            )
            
        }
        
        return Observable
            .merge([show, hide])
            .share(replay: 1, scope: .forever)
            .compactMap { $0 }
    }()
    
    static func registerDidShow(animatedHandler: @escaping ()->()) -> Disposable {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardDidShowNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in animatedHandler() })
    }
    
    static func register(handler: @escaping (_ params: PresentingParams) -> ()) -> Disposable {
        return keyboardPresenting
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {  handler($0) })
    }
    
    static func register(animatedHandler: @escaping (_ params: PresentingParams) -> ()) -> Disposable {
        return KeyboardHandler.register(handler: { (params) in
            UIView.animate(withDuration: params.animationDuration, animations: {
                animatedHandler(params)
            })
        })
    }
    
    static func register(scrollView: UIScrollView, additionalInsets: Insets = .never) -> Disposable {
        
        return KeyboardHandler.register(animatedHandler: { (params) in
            let height = params.keyboardSize.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        })
        
    }
    
    static func register(constraint: NSLayoutConstraint, additionalInsets: Insets = .never, aditionalAnimationBlock: (() -> ())? = nil) -> Disposable {
        return KeyboardHandler.register(animatedHandler: { (params) in
            let height = additionalInsets.add(to:  params.keyboardSize.height, with: params.state)
            constraint.constant = height
            aditionalAnimationBlock?()
        })
    }
}
