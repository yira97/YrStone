//
//  YrStoneApp.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/05.
//

import SwiftUI

@main
struct YrStoneApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(RecordCollectionViewModel.NewInstance())
        }
    }
}
