//
//  NetworkConstants.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Hosts: String {
    case openLibrary = "openlibrary.org"
    case coverOpenLibrary = "covers.openlibrary.org"
}

enum Schemes: String {
    case http
    case https
}
