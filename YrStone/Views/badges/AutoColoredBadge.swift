//
//  AutoColoredBadge.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/27.
//

import SwiftUI

struct AutoColoredBadge: View {
    var label: String
    var width: CGFloat = 50
    var height: CGFloat?
    var frontColor = Color.white
    
    var body: some View {
        let (r, g, b) = label.hashedRGB
        ZStack(alignment:.center) {
            Color(red: r, green: g, blue: b)
                .saturation(0.5)
            Text(label)
                .font(.system(.largeTitle, design: .serif).italic())
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
        }
        .frame(width: width, height: height != nil ? height! : width)
    }
}

struct AutoColoredBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AutoColoredBadge(label: "Zoom")
            AutoColoredBadge(label: "Mooz")
            AutoColoredBadge(label: "Zoob",width: 100)
            AutoColoredBadge(label: "Aoob",width: 300)
            AutoColoredBadge(label: "ao")
            AutoColoredBadge(label: "bo")
            AutoColoredBadge(label: "co",width:300, height:100)
            AutoColoredBadge(label: "p", width: 100, height: 300)
        }
        .background(Color.black)
    }
}
