//
//  Color.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/16.
//

import SwiftUI

extension Color {
    static let AppPrimary5 = Color("AppPrimary0.5")
    static let AppPrimary3 = Color("AppPrimary0.3")
    static let AppPrimary2 = Color("AppPrimary0.2")
    static let AppText = Color("AppText")
    private static let _AppBackground = Color("AppBackground")
    private static let _AppBackgroundVariation = Color("AppBackgroundVariation")
    static let AppCanvas = _AppBackground
    static let AppTextFieldBackground = _AppBackgroundVariation
    static let AppCardBackground = _AppBackgroundVariation
}

extension Color {
    static let AppTextInv = AppCardBackground
    static let AppCardBackgroundInv = AppText
}
