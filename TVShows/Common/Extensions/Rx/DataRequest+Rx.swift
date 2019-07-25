//
//  DataRequest+Rx.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import CodableAlamofire


extension DataRequest: ReactiveCompatible {}

extension Reactive where Base == DataRequest {
    
    func responseDecodableObject<T: Decodable>(
        queue: DispatchQueue? = nil,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder())
        -> Single<T> {
            
            return Single<T>.create { [weak base] (single) -> Disposable in
                
                let request = base?.responseDecodableObject(
                    queue: queue,
                    keyPath: keyPath,
                    decoder: decoder,
                    completionHandler: { (response: DataResponse<T>) in
                        switch response.result {
                        case .success(let value): single(.success(value))
                        case .failure(let error): single(.error(error))
                        }
                })
                
                return Disposables.create {
                    request?.cancel()
                }
            }
    }
    
    func response(queue: DispatchQueue? = nil) -> Completable {
        return Completable.create(subscribe: { [weak base] (completable) -> Disposable in
            let request = base?.response(
                queue: queue,
                completionHandler: { (response) in
                    if let error = response.error {
                        completable(.error(error))
                    } else {
                        completable(.completed)
                    }
            })
            
            return Disposables.create {
                request?.cancel()
            }
        })
    }
}

extension SessionManager: ReactiveCompatible {}
extension Reactive where Base == SessionManager {
    
    var manager: Single<SessionManager> {
        return Single.just(base)
    }
    
}
