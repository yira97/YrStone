//
//  AvatarBase.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/09/02.
//

import SwiftUI

struct AvatarBase: View {
    var index: Int?
    var width:CGFloat = 50
    var background: Color = Color.AppPrimary2
    
    var body: some View {
        ZStack(alignment:.bottom) {
            background
            Image.AppDefaultAvatar(index ?? 1)
                .resizable()
                .scaledToFit()
        }
        .frame(width: width, height: width)
    }
}

struct AvatarBase_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AvatarBase()
            AvatarBase()
                .clipShape(Circle())
            AvatarBase(width: 100)
            AvatarBase(width: 100)
                .clipShape(Circle())
        }
    }
}
