//
//  BookTableViewCell.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation
import UIKit

final class BookTableViewCell: UITableViewCell {
    private let networkManager = NetworkManager.shared
    private lazy var defaultCover =  UIImage(systemName: "text.book.closed")
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookCover: UIImageView! {
        didSet {
            bookCover.layer.cornerRadius = bookCover.frame.width / 10
        }
    }
    
    func configure(with book: Book) {
        bookTitle.text = book.title
        guard let bookCoverID = book.coverI else {
            bookCover.image = defaultCover
            return
        }
        networkManager.getCover(from: bookCoverID) { [weak self] result in
            switch result {
            case let .success(Data):
                self?.bookCover.image = UIImage(data: Data)
            case let .failure(error):
                self?.bookCover.image = self?.defaultCover
                print(error)
            }
        }
    }
}
