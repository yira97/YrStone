//
//  Image.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/24.
//

import SwiftUI

extension Image {
    static var OrganizationIcon = Image(systemName: "building.2.fill")
    static var IdentityIcon = Image(systemName: "person.fill.viewfinder")
    static var RefreshIcon = Image(systemName: "arrow.triangle.2.circlepath")
    
    static let AppDefaultAvatarCount = 15
    static func AppDefaultAvatar(_ idx: Int) -> Image {
        
        let n = (
                idx < 1 ||
                idx > AppDefaultAvatarCount
                ) ? 1 : idx
        
        return Image("AppDefaultAvatar_\(n)")
    }
}
