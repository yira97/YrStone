//
//  ToolBarButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct ToolBarButton: ButtonStyle {
    var rotate: Bool = false
    var frontColor = Color.AppTextInv
    var backColor = Color.AppCardBackgroundInv
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(!rotate ? frontColor : backColor)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .foregroundColor(!rotate ? backColor : frontColor)
            )
    }
}

struct ToolBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action:{}) {
            Image.IdentityIcon
        }
        .buttonStyle(ToolBarButton())
    }
}
