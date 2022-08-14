//
//  AddSthButton.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/27.
//

import SwiftUI

struct AddSthButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            Image(systemName: "plus.circle")
            configuration.label
        }
        .bold()
        .foregroundColor(.AppPrimary2)
    }
}

struct AddSthButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Add field") {
            print("add field")
        }
        .buttonStyle(AddSthButton())
    }
}
