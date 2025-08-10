//
//  ChapterModel.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import Foundation

// MARK: - Chapter
struct ChapterResponse: Codable, Equatable {
    let id = UUID()
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case chapters
    }
}

struct Chapter: Codable, Equatable {
    let id: String?
    let book: String?
    let chapter: Int?

    enum CodingKeys: String, CodingKey {
        case id = "book_id"
        case book
        case chapter
    }
    
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Chapter {
    static let mock = Self(
        id: "JHN",
        book: "John",
        chapter: 1)
    
}
