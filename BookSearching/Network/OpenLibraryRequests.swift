//
//  OpenLibraryRequests.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation

enum OpenLibraryRequests: BuildRequest {
    var scheme: String { Schemes.https.rawValue }
    var method:  HTTPMethod { .get}
    
    case searchBooks(query: String)
    case coverImage(coverId: Int)
    
    var host: String {
        switch self {
        case .searchBooks:
            return Hosts.openLibrary.rawValue
        case .coverImage:
            return Hosts.coverOpenLibrary.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .searchBooks:
            return "/search.json"
        case .coverImage(let coverId):
            return "/b/id/\(coverId)-M.jpg"
        }
    }
    var urlQuery: [String : String] {
        switch self {
        case .searchBooks(let query):
            return ["q": query, "limit":"10"]
        case .coverImage:
            return [:]
        }
    }
}
