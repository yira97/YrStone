//
//  NoRecordPlaceholder.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/23.
//

import SwiftUI

struct NoRecordPlaceholder: View {
    var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.AppPrimary2)
                .opacity(0.5)
                .frame(width: 60,height:60)
            Text("No Record")
                .foregroundColor(Color.AppPrimary2)
                .bold()
                .opacity(0.6)
        }
        .padding()
    }
}

struct NoRecordPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        NoRecordPlaceholder()
    }
}
