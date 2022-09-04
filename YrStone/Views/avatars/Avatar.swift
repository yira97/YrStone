//
//  Avatar.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/09/02.
//

import SwiftUI

struct Avatar: View {
    var width: CGFloat = 120
    @State var showSelectAvatar =  false
    @Binding var inputAvatarIndex: Int
    var editable = true
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarBase(index: inputAvatarIndex, width: width)
                .clipShape(Circle())
                .padding(5)
                .background(
                    Circle()
                        .foregroundColor(Color.AppCardBackground)
                )
            if (editable) {
                Button(action:{showSelectAvatar = true}) {
                    Image.RefreshIcon
                        .foregroundColor(Color.AppTextInv)
                        .padding(5)
                        .background(Color.AppText)
                        .clipShape(Circle())
                }
                .padding(5)
            }
        }
        .sheet(isPresented: $showSelectAvatar) {
            let gridItems = [GridItem(.adaptive(minimum: 100, maximum: 100 * 2))]
            ScrollView {
                Text("Select Avatar")
                    .font(.title2)
                LazyVGrid(columns: gridItems) {
                    ForEach(1...Image.AppDefaultAvatarCount, id: \.self) { idx in
                        AvatarBase(index: idx, width: .infinity, background: Color.AppPrimary2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    inputAvatarIndex = idx
                                    showSelectAvatar = false
                                }
                    }
                }
            }
            .padding()
            .background(Color.AppCanvas)
            .presentationDetents([.medium])
        }
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(inputAvatarIndex: .constant(2))
    }
}
