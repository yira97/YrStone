//
//  ContentView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/05.
//

import SwiftUI

struct AppView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.AppTabBarBackgroundColor
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    VStack {
                        Text("Collection")
                        Image(systemName: "books.vertical")
                    }
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(Color.AppPrimary3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppView()
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
                .previewDisplayName("light")
            AppView()
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
                .preferredColorScheme(.dark)
                .previewDisplayName("dark")
        }
    }
}
