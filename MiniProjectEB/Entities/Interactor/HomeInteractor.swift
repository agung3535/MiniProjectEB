//
//  HomeInteractor.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation

protocol HomeInteractorProcol {
    func getListUser(completion: @escaping(Result<ListUserInfo, Error>) -> Void)
}

class HomeInteractor: HomeInteractorProcol {
    private let repo: HomeRepositoryProtocol
    
    init(repo: HomeRepositoryProtocol) {
        self.repo = repo
    }
    
    func getListUser(completion: @escaping (Result<ListUserInfo, Error>) -> Void) {
        repo.getListUser(result: { data in
            completion(data)
        })
    }
    
    
}
