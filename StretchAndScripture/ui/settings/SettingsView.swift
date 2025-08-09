//
//  SettingsView.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//


import SwiftUI

struct SettingView: View {
    
    var body: some View {
        VStack{
            Text("settings pe")
                .font(.boldWithSize20)
                .padding()
            Divider()
            
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                HStack{
                    Text("settings pe")
                    Spacer()
                    HStack{
                        Image(systemName: "chevron.forward")
                    }
                }
            })
            .foregroundColor(.black)
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
