//
//  Book.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 11.03.2025.
//

struct BookSearchResult: Codable {
    let docs: [Book]
}

struct Book: Codable {
    let authorKey: [String]
    let authorName: [String]
    let coverI: Int?
    let title: String
    let key: String
}
