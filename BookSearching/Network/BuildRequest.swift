//
//  BuildRequest.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation

protocol BuildRequest {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var urlQuery: [String : String] { get }
    var method: HTTPMethod { get }
}

extension BuildRequest {
    
    func asRequest() throws -> URLRequest {
        var components: URLComponents = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = urlQuery.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        print("url = \(url)")
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
        
    }
}


