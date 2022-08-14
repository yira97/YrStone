//
//  PrimaryButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.AppTextLight)
            .font(.title2)
            .padding(.horizontal)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .foregroundColor(.AppPrimary3)
                    .shadow(color: .AppPrimary3.opacity(0.6), radius: 10)
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

