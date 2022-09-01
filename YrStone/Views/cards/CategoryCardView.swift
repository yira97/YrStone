//
//  CategoryCardViewswift.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/23.
//

import SwiftUI

struct CategoryCardView<Background: View>: View {
    var background: Background
    var text: String
    var textColor = Color.white.opacity(0.7)
    var icon: Image
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .frame(width: 150, height: 120)
                .foregroundColor(.clear)
                .background(
                    background
                        .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                )
                .overlay(
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50,height: 50)
                            .foregroundColor(textColor)
                            .padding([.top,.trailing])
                    ,alignment: .topTrailing
                )
            Text(text)
                .foregroundColor(textColor)
                .bold()
                .padding()
        }
    }
}

struct CategoryCardViewswift_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(
            background: Color.AppPrimary3,
            text: "identities",
            icon: Image.IdentityIcon
        )
    }
}
