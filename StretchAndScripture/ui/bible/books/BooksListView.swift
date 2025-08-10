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
    @State private var expandedBookID: String? = nil
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.booksList, id: \.id) { book in
                        BookRow(
                            book: book,
                            isExpanded: expandedBookID == book.id
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            expandedBookID = expandedBookID == book.id ? nil : book.id
                        }
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                viewStore.send(.fetchBooks)
            }
        }
    }
}
struct BookRow: View {
    let book: Book
    let isExpanded: Bool
    
    let columns = [
        GridItem(.adaptive(minimum: 40), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(book.name ?? "")
                    .font(.headline)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            
            if isExpanded {
                
                let totalChapters = book.chapters ?? 0
                let range: ClosedRange<Int> = 1...totalChapters
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    ForEach(range, id: \.self) { chapter in
                        Text("\(chapter)")
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ChapterButtonsView: View {
    let total: Int
    
    var body: some View {
        let chapters = Array(1...total) // <- Esto lo tipa explícitamente
        return HStack(spacing: 8) {
            ForEach(chapters, id: \.self) { chapter in
                Text("\(chapter)")
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
            }
        }
    }
}



//
//struct BooksListView: View {
//    let store: StoreOf<BooksListFeature>
//
//    var body: some View {
//        WithViewStore(store, observe: { $0 }) { viewStore in
//            NavigationView {
//                WithViewState(viewStore.viewState, isRefreshable: true) {
//                    List {
//                        ForEach(viewStore.booksList, id: \.id){ book in
//
//                            BookCell(model: book)
//                                .frame(height: 90)
//                                .onTapGesture {
////                                    viewStore.send(.did)
//                                }
//
////                            StretchCell(model: stretch)
////                                .frame(height: 90)
////                                .onTapGesture {
////                                    viewStore.send(.didSelectStretch(stretch: stretch))
////                                }
//                        }
//                    }
//                    .listStyle(.plain)
//
//                } loadingContent: {
//                    ScrollView {
//                        ForEach((0...10), id: \.self) { _ in
//                            BookCell(model: .mock)
//                        }
//                    }
//                    .redacted(reason: .placeholder)
//                    .padding()
//                } retryHandler: {
////                    viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
//                }
//                .navigationTitle(Str.books.key)
//                .navigationViewStyle(.stack)
//
////                .navigation(
////                    item:
////                        viewStore.binding(
////                            get: \.selectedArticle,
////                            send: .didSelectArticle(article: nil)
////                        )
////                ) {
////                    NewsDetailsView(model: $0)
////                }
//            }
//            .onAppear{
//                print("StretchesListView onAppear")
//                viewStore.send(.fetchBooks)
//            }
////            .searchable(text: $searchQuery)
////            .onChange(of: searchQuery) { newValue in
////                viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
////            }
//        }
//    }
//}
//struct BooksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BooksListView()
//    }
//}
