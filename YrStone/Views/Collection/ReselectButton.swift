//
//  ReselectButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct ReselectButton: View {
    var icon: Image = Image(systemName: "arrow.triangle.2.circlepath")
    var action: () -> Void = {}
    var dimension: CGFloat
    var body: some View {
        icon
            .resizable()
            .scaledToFit()
            .frame(width: dimension*0.6,height: dimension*0.6)
            .foregroundColor(.AppTextLight)
            .background(
                Circle()
                    .foregroundColor(Color.AppPrimary2)
                    .frame(width: dimension,height: dimension)
            )
            .onTapGesture {
                action()
            }
    }
}

struct ReselectButton_Previews: PreviewProvider {
    static var previews: some View {
        ReselectButton(dimension: 50)
    }
}
