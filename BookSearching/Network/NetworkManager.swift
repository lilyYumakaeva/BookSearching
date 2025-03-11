//
//  NetworkManager.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation

final class NetworkManager {
    
    private let apiLayer = ApiLayer.shared
    
    public static let shared = NetworkManager()
    private init() {}
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func searchBooks(query: String, _ callbak: @escaping (Result<[Book], NetworkError>) -> Void) {
        let request = try! OpenLibraryRequests.searchBooks(query: query).asRequest()
        apiLayer.makeRequest(request) { result in
            switch result {
            case .failure(let someError):
                callbak(.failure(someError))
            case .success(let responseData):
                //print("RESPONE IS: \(String.init(data: responseData, encoding: .utf8))")
                if let parsed = try? self.decoder.decode(BookSearchResult.self, from: responseData) {
                    let response = parsed.docs
                    let books = response.map{ book in
                        Book(
                            authorKey: book.authorKey,
                            authorName: book.authorName,
                            coverI: book.coverI,
                            title: book.title,
                            key: book.key
                        )
                    }
                    callbak(.success(books))
                }
                else {
                    callbak(.failure(.invalidParsing))
                }
            }
        }
    }
    
    func getCover(from coverId: Int, _ callbak: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = try! OpenLibraryRequests.coverImage(coverId: coverId).asRequest()
        apiLayer.makeRequest(request) { result in
            switch result {
            case .failure(let someError):
                callbak(.failure(someError))
            case .success(let responseData):
                DispatchQueue.main.async {
                    callbak(.success(responseData))
                }
            }
        }
    }
}
