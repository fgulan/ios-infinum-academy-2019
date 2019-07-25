//
//  Service.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class Service {
    static var instance = Service()
}

extension Service {
    
    func request<T: Decodable>(router: Router, keyPath: String = "data") -> Single<T> {
        return Single.just(ShowsSessionManager.session)
            .map { $0.request(router) }
            .map { $0.validate() }
            .flatMap { $0.rx.responseDecodableObject(keyPath: keyPath) }
    }
    
    func request<T: Decodable>(_: T.Type, router: Router) -> Single<T> {
        return request(router: router)
    }
    
    func requestCompletion(router: Router) -> Single<Void> {
        return Single.just(ShowsSessionManager.session)
            .map { $0.request(router) }
            .map { $0.validate() }
            .flatMap { $0.rx.response().andThen(Single.just(())) }
    }
    
}
