//
//  LikedBookTableViewCell.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 18.03.2025.
//

import Foundation
import UIKit

typealias RemoveCallback = (Book) -> Void

final class LikedBookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    public var removeButtonPressed: RemoveCallback?
    
    private var currentBook: Book!
    
    @IBAction func removeButtonDidTap(_ sender: Any) {
        removeButtonPressed?(currentBook)
    }
    
    func configure(with book: Book) {
        currentBook = book
        titleLabel.text = book.title
        authorLabel.text = book.authorName.joined(separator: ", ")
       
    }
}
