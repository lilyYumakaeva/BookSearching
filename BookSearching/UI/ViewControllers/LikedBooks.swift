//
//  LikedBooks.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 18.03.2025.
//

import Foundation
import UIKit

final class LikedBooksViewController: UITableViewController {
    private var books: [Book] = []
    
    private let coreDataManager = CoreDataManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBooksFromCoreData()
    }
    
    private func getBooksFromCoreData() {
        self.books = coreDataManager.getBooks()
        print(books)
    }
    
}

//MARK: - UITableViewDataSource
extension LikedBooksViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "likedBookCell") as? LikedBookTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: books[indexPath.row])
        cell.removeButtonPressed = { book in
            self.coreDataManager.deleteBook(book: book)
            self.getBooksFromCoreData()
            self.tableView.reloadData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Remembered books"
    }
    
}
