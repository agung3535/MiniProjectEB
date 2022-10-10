//
//  HomeRemoteDataSource.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation

protocol HomeRemoteDataSourceProtocol {
    func getListUser(result: @escaping(Result<ListUserInfo, Error>) -> Void)
}

class HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    func getListUser(result: @escaping (Result<ListUserInfo, Error>) -> Void) {
        APIService.shared.requestResource(serviceURL: Route.GetUser.url, httpMethod: .GET, parameters: [:], decode: ListUserInfo.self, completion: { response, error in
            if response != nil {
                result(.success(response!))
            }else if error != nil {
                result(.failure(error!))
            }
        })
    }
   
    
    
}
