//
//  BibleClient.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import ComposableArchitecture
import XCTestDynamicOverlay
import Foundation

struct BibleClient {
    var books: () async throws -> [Book]
}

extension DependencyValues {
    var bibleClient: BibleClient {
        get { self[BibleClient.self] }
        set { self[BibleClient.self] = newValue }
    }
}

extension BibleClient: TestDependencyKey {
    static var previewValue: BibleClient {
        return .init(
            books: { [] }
        )
    }
    
    static var testValue: BibleClient {
        return .init (
            books: unimplemented("\(Self.self).List")
        )
    }
}

extension BibleClient: DependencyKey {
    static let liveValue = BibleClient (
        books: {
            
            let books = try await fetchBooks()
        
            var tasks: [Task<Book, Error>] = []
            
            for book in books {
                let task = Task { () throws -> Book in
                    do {
                        let chapters = try await fetchChapters(for: book.id ?? "").count
                        return Book(id: book.id, name: book.name, chapters: chapters)
                    } catch {
                        return Book(id: book.id, name: book.name, chapters: 0)
                    }
                }
                tasks.append(task)
            }
            
            var results: [Book] = []
            for task in tasks {
                results.append(try await task.value)
            }
            return results
        }
    )
    
    static func fetchBooks() async throws -> [Book] {
        let request = BibleRequests.getBooks(version: "web")
        let booksResponse = try await APIFetcher.shared.fetch(baseUrl: "https://bible-api.com", request: request, responseClass: BooksResponse.self)
        return booksResponse.books
      }
    
    static func fetchChapters(for bookId: String) async throws -> [Chapter] {
        let request = BibleRequests.getChapters(book: bookId)
        print("2SA chapters:", request.requestUrlDynamic(baseUrl: "https://bible-api.com"))  // debería imprimir 24
        let chapterResponse = try await APIFetcher.shared.fetch(baseUrl: "https://bible-api.com", request: request, responseClass: ChapterResponse.self)
        print("listsss chapters:", chapterResponse.chapters.count)  // debe
        return chapterResponse.chapters
    }
}
