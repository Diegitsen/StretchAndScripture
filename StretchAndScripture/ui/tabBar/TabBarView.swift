//
//  TabBarView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//


import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    
    var body: some View {
        TabView {
            StretchesListView(store: StoreOf<StretchesListFeature>(
                initialState: .init(),
                reducer: {
                    StretchesListFeature(client: YogaClient.liveValue)
                }))
            .tabItem {
                Label("home", systemImage: "house.fill")
            }
            
            BooksListView(store: StoreOf<BooksListFeature>(
                initialState: .init(),
                reducer: {
                    BooksListFeature(client: BibleClient.liveValue)
                }))
            .tabItem {
                Label("books", systemImage: "book")
            }
            
            //gear
            SettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("settings")
                    }
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
