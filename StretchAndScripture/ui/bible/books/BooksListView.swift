//
//  BooksListView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//

import SwiftUI
import ComposableArchitecture

struct BooksListView: View {
    let store: StoreOf<BooksListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                WithViewState(viewStore.viewState, isRefreshable: true) {
                    List {
                        ForEach(viewStore.booksList, id: \.id){ book in
                            
                            BookCell(model: book)
                                .frame(height: 90)
                                .onTapGesture {
//                                    viewStore.send(.did)
                                }
                            
//                            StretchCell(model: stretch)
//                                .frame(height: 90)
//                                .onTapGesture {
//                                    viewStore.send(.didSelectStretch(stretch: stretch))
//                                }
                        }
                    }
                    .listStyle(.plain)
                    
                } loadingContent: {
                    ScrollView {
                        ForEach((0...10), id: \.self) { _ in
                            BookCell(model: .mock)
                        }
                    }
                    .redacted(reason: .placeholder)
                    .padding()
                } retryHandler: {
//                    viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
                }
                .navigationTitle(Str.books.key)
                .navigationViewStyle(.stack)
                
//                .navigation(
//                    item:
//                        viewStore.binding(
//                            get: \.selectedArticle,
//                            send: .didSelectArticle(article: nil)
//                        )
//                ) {
//                    NewsDetailsView(model: $0)
//                }
            }
            .onAppear{
                print("StretchesListView onAppear")
                viewStore.send(.fetchBooks)
            }
//            .searchable(text: $searchQuery)
//            .onChange(of: searchQuery) { newValue in
//                viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
//            }
        }
    }
}
struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView(
            store: .init(
                initialState: BooksListFeature.State(),
                reducer: {}))
    }
}
