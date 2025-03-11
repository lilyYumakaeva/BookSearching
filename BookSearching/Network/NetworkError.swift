//
//  NetworkError.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 11.03.2025.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case invalidURLResponse
    case invalidStatusCode
    case serverError
    case clientError
    case noResult
    case invalidURL
    case invalidParsing
}
