//
//  ToolBarButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct ToolBarButton: ButtonStyle {
    var revColor: Bool = false
    var iconColor = Color.AppPrimary5
    var backgroundColor = Color.AppBackgroundLight
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(revColor ? backgroundColor : iconColor)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 13,style: .continuous)
                    .foregroundColor(revColor ? iconColor : backgroundColor)
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
