//
//  WebServices.swift
//  MVVMHotCoffee
//
//  Created by 2B on 20/11/2023.
//

import Foundation

enum NetworkError : Error{
    case domainError
    case decodingError
}

enum HTTPMethods : String {
    case get = "GET"
    case post = "POST"
}

struct Resources<T:Codable>{
    let url : URL
    var method : HTTPMethods = .get
    var data : Data? = nil
}

class WebServices {
    
    func loadData<T>(resources: Resources<T>,completion: @escaping (Result<T,NetworkError>)->Void){
        
        var request = URLRequest(url: resources.url)
        request.httpBody = resources.data
        request.httpMethod = resources.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request , request.httpBody , request.httpMethod)
        URLSession.shared.dataTask(with: request) { data, responce , error in
            
            guard let data = data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(T.self, from: data)
                completion(.success(results))
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
}
