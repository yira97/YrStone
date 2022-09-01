//
//  ReselectButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    var color: Color = Color.AppPrimary2
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(
                Circle()
                    .foregroundColor(color)
            )
    }
}

struct SecondaryRoundButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Image.RefreshIcon
        }
        .buttonStyle(RoundButton())
    }
}
