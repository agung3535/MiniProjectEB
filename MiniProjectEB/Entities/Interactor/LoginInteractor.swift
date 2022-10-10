//
//  LoginInteractor.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation

protocol LoginInteractorProcol {
    func login(body: [String: String], completion: @escaping(Result<LoginResponse, Error>) -> Void)
}

class LoginInteractor: LoginInteractorProcol {
    private let repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol) {
        self.repo = repo
    }
    
    func login(body: [String : String], completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        repo.login(body: body, result: { data in
            completion(data)
        })
    }
    
    
}
