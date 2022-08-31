//
//  RoundedIconTextField.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct RoundedIconTextField: View {
    @Binding var value: String
    var icon: Image
    var label: String
    var editable: Bool = true
    var width: CGFloat = .infinity
    var height: CGFloat = 60
    var color: Color = Color.AppPrimary5
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                if (!editable) {
                    Text(value)
                } else {
                    TextField(label, text: $value)
                        .textFieldStyle(.plain)
                }
            }
            .foregroundColor(color)
            .padding(.leading,50)
            .frame(width: gr.size.width, height:gr.size.height, alignment: .leading)
            .overlay(alignment: .leading, content: {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(Color.AppPrimary5)
                    .opacity(0.8)
                    .padding(.leading)
            })
            .background(
                RoundedRectangle(cornerRadius:50)
                    .foregroundColor(.AppSecondary(colorScheme))
                    .frame(width: gr.size.width, height: gr.size.height)
            )
        }
        .frame(width: width, height: height)
    }
}

struct RoundedIconTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedIconTextField(value: .constant("TextField"), icon: Image.OrganizationIcon, label: "username",editable: true)
            RoundedIconTextField(value: .constant("Text"), icon: Image.OrganizationIcon, label: "username", editable: false)
        }
        .background(Color.black)
    }
}
