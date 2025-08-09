//
//  SplashView.swift
//  

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Stretch and Scriptures")
            Image.icon
                .resizable()
                .frame(height: 150)
            
            Spacer()
            
            ProgressView()
                .progressViewStyle(.circular)
                .padding(.bottom, 30)
    
        }
        .padding()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
        
    }
}
