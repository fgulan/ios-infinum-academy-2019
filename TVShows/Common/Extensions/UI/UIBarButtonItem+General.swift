//
//  UIBarButtonItem+General.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit
import RxSwift

extension UIBarButtonItem {
    
    convenience init(barButtonSystemItem: UIBarButtonItem.SystemItem, action: (()->())? = nil) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
        self.rx.tap
            .asDriver()
            .drive(onNext: { action?() })
            .disposed(by: disposeBag)
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style = .plain, action: (()->())? = nil) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.rx.tap
            .asDriver()
            .drive(onNext: { action?() })
            .disposed(by: disposeBag)
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItem.Style = .plain, action: (()->())? = nil) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.rx.tap
            .asDriver()
            .drive(onNext: { action?() })
            .disposed(by: disposeBag)
    }
    
    private var disposeBag: DisposeBag {
        let lookup = objc_getAssociatedObject(self, associatedKeysDisposeBag) as? DisposeBag
        if let lookup = lookup {
            return lookup
        }
        let newDisposeBag = DisposeBag()
        objc_setAssociatedObject(self, associatedKeysDisposeBag, newDisposeBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return newDisposeBag
    }
    
    private var associatedKeysDisposeBag: String {
        return "UIBarButtonItem.rx.disposeBag"
    }
}
