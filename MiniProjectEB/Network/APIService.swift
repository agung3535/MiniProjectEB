//
//  APIService.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


enum HTTPMethod: String {
    case GET
    case POST
}


final class APIService {
    
    static let shared = APIService()
    
    private init(){}
    
    struct Constant {
        static let baseAPIURL = "https://reqres.in/api/"
    }
    
    
    func createRequest(url: URL?, type: HTTPMethod, completion: @escaping(URLRequest) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    func requestResource<T:Decodable>(serviceURL:String,httpMethod:HTTPMethod,parameters:[String:String]?, decode: T.Type,completion:@escaping (T?, Error?) -> Void) -> Void {
            
        var request = URLRequest(url: URL(string:"\(Constant.baseAPIURL)\(serviceURL)")!)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = httpMethod.rawValue
        if httpMethod != HTTPMethod.GET {
            if (parameters != nil ) {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            }
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            print("resposne = \(Constant.baseAPIURL)\(serviceURL)")
            guard let urlResponse = response as? HTTPURLResponse else { return completion(nil, error)}
            print("status code = \(urlResponse.statusCode)")
            if !(200..<300).contains(urlResponse.statusCode) {
                if (400...402).contains(urlResponse.statusCode){
                    print("masuk error status =\(urlResponse.statusCode)")
                    completion (nil,ErrorHelper.unknownError("Authentication Failed"))
                }
            }else {
                if (data != nil){
                    do {
                        let result2 = try JSONDecoder().decode(decode, from: data!)
                        completion (result2, nil)
                    }catch {
                        print("Error decode")
                    }
    //                let result = try? JSONDecoder().decode(decode, from: data!)
    //                print("result = \(result)")
    //                completion (result, nil)
                }
                    
                
            }
            if (error != nil) {
                completion (nil,error!)
            }
            
        }
        sessionTask.resume()
        }
    
    private func decodeData<T: Decodable>(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch(let error) {
            print("masuk error decode = \(error.localizedDescription)")
            return nil
        }
    }
    
}
