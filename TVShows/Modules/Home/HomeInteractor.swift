//
//  HomeInteractor.swift
//  TVShows
//
//  Created by Filip Gulan on 29/07/2018.
//  Copyright (c) 2018 Filip Gulan. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class HomeInteractor {
    
    private let _service: Service
    private let _sessionManager: SessionManager
    
    init(service: Service = .instance, sessionManager: SessionManager = ShowsSessionManager.session) {
        _service = service
        _sessionManager = sessionManager
    }
}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {
    
    func loadShows() -> Single<[Show]> {
        return _service
            .request([Show].self, router: Router.Show.getShows())
    }
}