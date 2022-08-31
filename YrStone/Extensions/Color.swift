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
    static let AppTextLight = Color("AppTextLight")
    static let AppTextDark = Color("AppTextDark")
    static let AppSecondaryLight = Color("AppBackgroundLight")
    
    static func AppSecondary(_ colorSchene: ColorScheme) -> Color {
        colorSchene == .dark ? AppSecondaryLight.opacity(0.4) : AppSecondaryLight
    }
    
    static func AppText(_ colorSchene: ColorScheme) -> Color {
        colorSchene == .dark ? AppTextLight : AppTextDark
    }
    
    static func AppBackground(_ colorSchene: ColorScheme) -> Color {
        colorSchene == .dark ? Color.AppPrimary5.opacity(0.7) :
         Color.AppPrimary5.opacity(0.1)
    }
}
