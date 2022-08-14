//
//  AutoColoredBadge.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/27.
//

import SwiftUI

struct AutoColoredBadge: View {
    var label: String
    var ratio = 0.95
    var body: some View {
        GeometryReader { geometry in
            let (r, g, b) = label.hashedRGB
            let width = min(geometry.size.width, geometry.size.width)
            Text(label)
                .font(.largeTitle)
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundColor(Color.AppTextLight)
                .frame(maxWidth: width*ratio, maxHeight: width*ratio)
                .background(
                    Circle()
                        .fill(Color(red: r/255, green: g/255, blue: b/255))
                        .saturation(0.6)
                        .opacity(0.8)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                )
        }
        
    }
}

struct AutoColoredBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AutoColoredBadge(label: "Indivisual")
                .frame(width: 40, height: 40)
            AutoColoredBadge(label: "Yiran")
                .frame(width: 40, height: 40)
            AutoColoredBadge(label: "Yiran")
                .frame(width: 50, height: 50)
            AutoColoredBadge(label: "Yiran")
                .frame(width: 70, height: 70)
            AutoColoredBadge(label: "Yiran")
                .frame(width: 100, height: 100)
            AutoColoredBadge(label: "Indivisual")
                .frame(width: 100, height: 100)
        }
    }
}
