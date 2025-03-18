//
//  BookDB+CoreDataProperties.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 18.03.2025.
//
//

import Foundation
import CoreData


extension BookDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDB> {
        return NSFetchRequest<BookDB>(entityName: "BookDB")
    }

    @NSManaged public var author_key: String?
    @NSManaged public var author_name: String?
    @NSManaged public var title: String?
    @NSManaged public var work_key: String?
    @NSManaged public var cover_id: Int32

}

extension BookDB : Identifiable {

}

extension BookDB {
    func makeBook() -> Book{
        return Book(
            authorKey: [self.author_key ?? ""],
            authorName: [self.author_name ?? ""],
            coverI: Int(self.cover_id),
            title: self.title ?? "",
            key: self.work_key ?? ""
        )
    }
}

