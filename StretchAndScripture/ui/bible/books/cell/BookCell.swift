//
//  BookCell.swift
//  StretchAndScripture
//
//  Created by diegitsen on 10/08/25.
//


import SwiftUI
import Kingfisher

struct BookCell: View {
    var model: Book
    
    var body: some View {
        Group {
            VStack {
                Text(model.name ?? "")
                    .font(.boldWithSize14)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
        }
        
        .background(
            Color.appWhite
                .cornerRadius(12)
                .shadow(color: .appBlackWithOpacity10, radius: 5)
        )
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .listRowSeparator(.hidden)
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(model: .mock)
    }
}
