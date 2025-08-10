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
    var books: () async throws -> BooksResponse
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
            books: { BooksResponse(books: []) }
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
            let request = BibleRequests.getBooks(version: "web")
            return try await APIFetcher.shared.fetch(baseUrl: "https://bible-api.com", request: request, responseClass: BooksResponse.self)
        }
    )
}
