//
//  StretchCell.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//

import SwiftUI
import Kingfisher

struct StretchCell: View {
    var model: Stretch
    
    var body: some View {
        Group {
            HStack {
                
                KFImage(model.url?.toURL)
                    .placeholder {
                        Image.icon
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                    }
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                
                VStack(alignment: .leading){
                    Unwrap(model.name){ title in
                        Text(title)
                            .font(.boldWithSize14)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    }
                    Unwrap(model.description){ author in
                        Text(author)
                    }
                    .font(.regularWithSize12)
                    .lineLimit(2)
                    .padding(.top, 2)
                }
                
                Spacer()
            }
            .padding()
        }
        .background(
            Color.appWhite
                .shadow(color: .appBlackWithOpacity10, radius: 5)
        )
        .listRowSeparator(.hidden)
    }
}

struct StretchCell_Previews: PreviewProvider {
    static var previews: some View {
        StretchCell(model: .mock)
    }
}
