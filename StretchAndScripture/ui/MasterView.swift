//
//  MasterView.swift
//  

import SwiftUI
import ComposableArchitecture

struct MasterView: View {
    @State var rootView: AppRootView? = .splash
    
    var body: some View {
        masterRootView
    }
    
    @ViewBuilder
    var masterRootView: some View {
        switch rootView {
        case .splash:
            SplashView(rootView: $rootView)
        case .language:
            SplashView(rootView: $rootView)
        case .home:
            TabBarView()
        default:
            SplashView(rootView: $rootView)
        }
    }
}
