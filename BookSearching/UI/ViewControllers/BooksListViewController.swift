//
//  BooksListViewController.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 12.03.2025.
//

import Foundation
import UIKit

final class BooksListViewController: UITableViewController {
    private var books: [Book] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.rowHeight = 80
    }
    
    func setBooks(books: [Book]) {
        self.books = books
    }
    
    // MARK: - Navigation
    private func goToSecondVC(withBook book: Book) {
        guard let bookVC = storyboard?.instantiateViewController(identifier: "BookViewController") as? BookViewController else {
            print("VC not initialised")
            return
        }
        bookVC.book = book
        self.present(bookVC, animated: true)
        //navigationController?.pushViewController(bookVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension BooksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as? BookTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: books[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Books"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToSecondVC(withBook: books[indexPath.row])
    }
}
