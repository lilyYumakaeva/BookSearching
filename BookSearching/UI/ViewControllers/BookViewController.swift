//
//  BookViewController.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 14.03.2025.
//
import UIKit

final class BookViewController: UIViewController {

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var bookIsLiked: UILabel!
    var book: Book!
    
    private let coreDataManager = CoreDataManager()
    
    @IBAction func addToFavorite(_ sender: Any) {
        coreDataManager.addBook(newBook: book)
        self.viewDidLoad()
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeBook(book)
    }
    
    private func composeBook(_ book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authorName.joined(separator: ", ")
        do {
            let bookCoverID = book.coverI ?? 0
            let url = try OpenLibraryRequests.coverImage(coverId: bookCoverID).getUrl()
            bookCoverImageView.kf.setImage(with: url)
        } catch {
            print("Error while creating URL")
            bookCoverImageView.image = UIImage(systemName: "text.book.closed")
        }
        
        let isLiked = coreDataManager.isLiked(book)
        if isLiked {
            bookIsLiked.isHidden = false
            addToFavoriteButton.isHidden = true//.setTitle("Remove from favorites", for: .normal)
        } else {
            bookIsLiked.isHidden = true
            addToFavoriteButton.setTitle("Remember book", for: .normal)
        }
    }
    
    
}
