//
//  NoRecordPlaceholder.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/23.
//

import SwiftUI

struct NoRecordPlaceholder: View {
    var color = Color.AppPrimary5
    var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 60,height:60)
            Text("No Record")
                .foregroundColor(color)
                .bold()
        }
        .padding()
    }
}

struct NoRecordPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        NoRecordPlaceholder()
    }
}
