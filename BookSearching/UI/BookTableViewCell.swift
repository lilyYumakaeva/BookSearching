//
//  BookTableViewCell.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation
import UIKit
import Kingfisher

final class BookTableViewCell: UITableViewCell {
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
        do {
            let url = try OpenLibraryRequests.coverImage(coverId: bookCoverID).getUrl()
            bookCover.kf.setImage(with: url)
        } catch {
            print("Error while creating URL")
            bookCover.image = defaultCover
        }
    }
}
