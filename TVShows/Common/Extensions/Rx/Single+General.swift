//
//  Single+Utility.swift
//
//  Created by Filip Gulan on 03/02/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

extension Single {

    /// Converts current Single sequence to Driver, completing on error event.
    ///
    /// - Returns: Driver - completing on error event
    func asDriverOnErrorComplete() -> Driver<Element> {
        return asDriver(onErrorDriveWith: .empty())
    }

}

extension PrimitiveSequenceType where Trait == SingleTrait {

    /// Maps sequence element to given value.
    ///
    /// - Parameter value: Value to map
    /// - Returns: Sequence where element is given value.
    func mapTo<T>(_ value: T) -> Single<T> {
        return map { _ in value }
    }

    /// Maps sequence element to Void type.
    ///
    /// - Returns: Sequence where element is of Void type.
    func mapToVoid() -> Single<Void> {
        return mapTo(())
    }

}

extension PrimitiveSequenceType where Trait == SingleTrait {

    /// Shows loading on subscribe event.
    func handleShowLoading(with progressable: Progressable) -> Single<Element> {
        return self
            .do(onSubscribe: { [unowned progressable] in progressable.showLoading() })
    }

    /// Hides loading on success event or error event.
    func handleHideLoading(with progressable: Progressable) -> Single<Element> {
        return self
            .do(onSuccess: { [unowned progressable] _ in progressable.hideLoading() })
            .do(onError: { [unowned progressable] _ in progressable.hideLoading() })
    }

    /// Shows loading on subscribe event and hides loading on success event or error event.
    func handleLoading(with progressable: Progressable) -> Single<Element> {
        return self
            .handleShowLoading(with: progressable)
            .handleHideLoading(with: progressable)
    }

    /// Shows failure on error event.
    func handleShowFailure(with progressable: Progressable) -> Single<Element> {
        return self
            .do(onError: { [unowned progressable] in progressable.showFailure(with: $0) })
    }

    /// Shows loading on subscribe event, hides loading on success
    /// event or error event and shows failure on error event.
    func handleLoadingAndError(with progressable: Progressable) -> Single<Element> {
        return self
            .handleLoading(with: progressable)
            .handleShowFailure(with: progressable)
    }

}
