//
//  BibleModel.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import Foundation

// MARK: - Book
struct BooksResponse: Codable, Equatable {
    let id = UUID()
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case books
    }
}

struct Book: Codable, Equatable {
    let id: String?
    let name: String?
    let chapters: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case chapters
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Book {
    static let mock = Self(
        id: "GEN",
        name: "Genesis",
        chapters: 34)
    
}
