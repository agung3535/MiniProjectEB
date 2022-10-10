//
//  Route.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation

enum Route {
    case Login
    case GetUser
    
    var url: String {
        switch self {
        case .Login:
            return "login"
        case .GetUser:
            return "users"
        }
    }
}
