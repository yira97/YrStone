//
//  gradients.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

extension LinearGradient {
    static var ForIdentity = LinearGradient(gradient: Gradient(colors: [Color.AppPrimary2, Color.AppPrimary3]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static var ForOrganization = LinearGradient(gradient: Gradient(colors: [Color.AppPrimary5, Color.AppPrimary2]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
