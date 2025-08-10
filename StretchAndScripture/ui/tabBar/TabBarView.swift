//
//  TabBarView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//


import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    
    
    @State private var selected = Date()
         var week: [DayProgress] {
            let cal = Calendar.current
            let start = cal.date(from: cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            return (0..<7).compactMap { offset in
                let d = cal.date(byAdding: .day, value: offset, to: start)!
                return DayProgress(
                    date: d,
                    progress: [0.0, 0.25, 0.6, 0.0, 0.0, 0.0, 0.85][offset]
                )
            }
        }
    
    var body: some View {
        TabView {
            WeekProgressPicker(selectedDate: $selected, items: week)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("settings")
                    }
                }
            
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
