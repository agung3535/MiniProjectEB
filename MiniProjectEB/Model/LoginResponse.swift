//
//  LoginResponse.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


struct LoginResponse: Codable {
    let token: String
}

struct ErrorLoginResponse: Codable {
    let error: String
}
