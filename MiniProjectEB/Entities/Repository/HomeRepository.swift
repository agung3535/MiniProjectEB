//
//  HomeRepository.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


protocol HomeRepositoryProtocol {
    func getListUser(result: @escaping(Result<ListUserInfo, Error>) -> Void)
}


class HomeRepository: HomeRepositoryProtocol {
    private let remote: HomeRemoteDataSourceProtocol
    
    init(remote: HomeRemoteDataSourceProtocol) {
        self.remote = remote
    }
    func getListUser(result: @escaping (Result<ListUserInfo, Error>) -> Void) {
        remote.getListUser(result: { remoteResponse in
            switch remoteResponse {
            case .success(let userResponse):
                result(.success(userResponse))
            case .failure(let error):
                result(.failure(error))
            }
        })
    }
    
}
