//
//  LoginRepository.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


protocol LoginRepositoryProtocol {
    func login(body: [String: String], result: @escaping(Result<LoginResponse, Error>) -> Void)
}


class LoginRepository: LoginRepositoryProtocol {
    private let remote: LoginRemoteDataSourceProtocol
    
    init(remote: LoginRemoteDataSourceProtocol) {
        self.remote = remote
    }
    func login(body: [String: String], result: @escaping (Result<LoginResponse, Error>) -> Void) {
        remote.login(body: body, result: { remoteResponse in
            switch remoteResponse {
            case .success(let loginResponse):
                result(.success(loginResponse))
            case .failure(let error):
                result(.failure(error))
            }
        })
    }
    
}
