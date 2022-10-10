//
//  LoginRemoteDataSource.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


protocol LoginRemoteDataSourceProtocol {
    func login(body: [String: String], result: @escaping(Result<LoginResponse, Error>) -> Void)
}

class LoginRemoteDataSource: LoginRemoteDataSourceProtocol {
    func login(body: [String : String], result: @escaping (Result<LoginResponse, Error>) -> Void) {
        APIService.shared.requestResource(serviceURL: Route.Login.url, httpMethod: .POST, parameters: body, decode: LoginResponse.self, completion: { response, error in
            if response != nil {
                result(.success(response!))
            }else if error != nil {
                result(.failure(error!))
            }
        })
    }
   
    
    
}
