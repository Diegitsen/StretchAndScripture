//
//  StretchesListView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//

import SwiftUI
import ComposableArchitecture


struct StretchesListView: View {
    let store: StoreOf<StretchesListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                WithViewState(viewStore.viewState, isRefreshable: true) {
                    List {
                        ForEach(viewStore.stretchesList, id: \.id){ stretch in
                            
                            StretchCell(model: stretch)
                                .frame(height: 90)
                                .onTapGesture {
                                    viewStore.send(.didSelectStretch(stretch: stretch))
                                }
                        }
                        
//                        if viewStore.state.shouldPaginate {
//                            Text(Str.fetchingNewRecords.key)
//                                .font(.regularWithSize12)
//                                .onAppear{
//                                    Helpers.shared.wait {
//                                        viewStore.send(.getNextPageIfNeeded)
//                                    }
//                                }
//                                .listRowSeparator(.hidden)
//                        }
                    }
                    .listStyle(.plain)
                    
                } loadingContent: {
                    ScrollView {
                        ForEach((0...10), id: \.self) { _ in
                            StretchCell(model: .mock)
//                            NewsCell(model: .mock)
                        }
                    }
                    .redacted(reason: .placeholder)
                    .padding()
                } retryHandler: {
//                    viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
                }
                .navigationTitle(Str.stretches.key)
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
                viewStore.send(.fetchStretches)
            }
//            .searchable(text: $searchQuery)
//            .onChange(of: searchQuery) { newValue in
//                viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
//            }
        }
    }
}
struct StretchesListView_Previews: PreviewProvider {
    static var previews: some View {
        StretchesListView(
            store: .init(
                initialState: StretchesListFeature.State(),
                reducer: {}))
    }
}
