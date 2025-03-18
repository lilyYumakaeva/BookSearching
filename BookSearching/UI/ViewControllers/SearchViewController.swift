//
//  ViewController.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 11.03.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    private let networkManager = NetworkManager.shared
    
    @IBOutlet weak var queryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressSearch(_ sender: Any) {
        guard let query = queryTextField.text else { return }
        
        getBooks(forQuery: query)
    }
    
    private func getBooks(forQuery query: String) {
        networkManager.searchBooks(query: query) { [weak self] result in
            switch result {
            case let .success(books):
                print(books)
                self?.goToBookListVC(withBooks: books)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func goToBookListVC(withBooks books: [Book]) {
        DispatchQueue.main.async {
            guard let bookListVC = self.storyboard?.instantiateViewController(identifier: "BooksListViewController") as? BooksListViewController else {
                print("VC not initialised")
                return
            }
            bookListVC.setBooks(books: books)
            self.present(bookListVC, animated: true)
        }
        
    }
}
