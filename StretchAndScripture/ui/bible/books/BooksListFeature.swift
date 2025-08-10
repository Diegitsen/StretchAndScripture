//
//  BooksListFeature.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct BooksListFeature: Reducer, NetworkHelper {
    
    let client: BibleClient
    init(client: BibleClient) { self.client = client }
    
    struct State: Equatable {
        var viewState: ViewState = .loading
        var booksList: [Book] = []
        var selectedBook: Book?
    }
    
    enum Action: Equatable {
        case fetchBooks
        case booksResponse(Result<BooksResponse, ActionError>)
        case didSelectBook(book: Book?)
    }
        
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchBooks:
            return .run { send in
                await send(
                    .booksResponse(
                        .success(
                            try await self.client.books()
                        )
                    )
                )
            }
        case .booksResponse(.success(let booksResponse)):
            state.booksList = booksResponse.books
            state.viewState = .loaded
            return .none
        case .booksResponse(.failure(let error)):
            state.viewState = failHandler(error)
            return .none
        case .didSelectBook(let book):
            state.selectedBook = book
            return .none
        }
    }
}
