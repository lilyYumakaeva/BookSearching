//
//  ApiLayer.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 11.03.2025.
//

import Foundation

final class ApiLayer {
    
    private let urlSession = URLSession.shared
   
    public static let shared = ApiLayer()
    private init() {}
    
    func makeRequest(
        _ request: URLRequest,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        urlSession.dataTask(with: request){ data, response, error in
           // print(response)
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            if let validError = self.validate(response) {
                completion(.failure(validError))
                return
            }
            guard let data = data else {
                completion(.failure(.noResult))
                return
            }
           
            completion(.success(data))
            
        }.resume()
       
    }
    
    private func validate(_ response: URLResponse?) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .invalidURLResponse
        }
        print("httpResponse.statusCode = \(httpResponse.statusCode)")
        switch httpResponse.statusCode {
        case 100..<200, 300..<400:
            return .invalidStatusCode
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            break
        }
        return nil
    }
}
