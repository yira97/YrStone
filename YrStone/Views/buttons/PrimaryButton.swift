//
//  PrimaryButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    var backColor = Color.AppPrimary3
    var frontColor = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(frontColor)
            .font(.title2)
            .padding(.horizontal)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .foregroundColor(backColor)
                    .shadow(color: backColor.opacity(0.5), radius: 5)
            )
            .padding()
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(PrimaryButton())
    }
}

