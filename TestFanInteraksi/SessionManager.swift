//
//  SessionManager.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 28/05/24.
//

import Foundation

class SessionManager{
    
    static var shared = SessionManager()
    
    internal func request<T: Decodable>(req: RequestProtocol, data: Data?, queryItems: [URLQueryItem], completion: @escaping((Result<T, Error>) -> Void)){
        guard let url = URL(string: "https://\(URLManager.baseUrl.url + req.path.url)")else{completion(.failure(CustomError.callApiFailBecauseURLNotFound));return}
        print("error: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = req.method.rawValue
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(CustomError.apiReturnNoData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300 && httpResponse.statusCode >= 200 else{
                print((response as? HTTPURLResponse)?.statusCode)
                completion(.failure(CustomError.somethingWentWrong))
                return
            }
            var decoder = JSONDecoder()
            do{
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                var model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            }catch{
                print(String(describing: error))
                completion(.failure(error))
            }
        }.resume()
    }
}

enum URLManager{
    case baseUrl
    case fetchUsers
    var url: String{
        switch self{
        case .baseUrl:
            return "serverfanintergrasi.adaptable.app/"
        case .fetchUsers:
            return "fetchUsers"
        }
    }
}


enum HTTPMethod: String{
    case get
    case post
}

enum ContentType: String{
    case formUrlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

