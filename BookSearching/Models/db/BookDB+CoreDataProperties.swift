//
//  BookDB+CoreDataProperties.swift
//  BookSearching
//
//  Created by Лилия Д. Юмакаева on 17.03.2025.
//
//

import Foundation
import CoreData


extension BookDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDB> {
        return NSFetchRequest<BookDB>(entityName: "BookDB")
    }

    @NSManaged public var author_key: String?
    @NSManaged public var work_key: String?
    @NSManaged public var title: String?
    @NSManaged public var author_name: String?

}

extension BookDB : Identifiable {

}
