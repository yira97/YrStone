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
                            .foregroundColor(.AppTextDark)
                            .opacity(0.6)
                            .padding([.top,.trailing])
                    ,alignment: .topTrailing
                )
            Text(text)
                .foregroundColor(Color.AppTextLight)
                .opacity(0.8)
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
