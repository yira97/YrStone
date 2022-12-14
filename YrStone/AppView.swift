//
//  ContentView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/05.
//

import SwiftUI

struct AppView: View {
    init() {
        // setting transparent navigation bar (globally)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor.AppTabBarBackgroundColor
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        // disable auto transparent feature
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
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

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppView()
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
        }
    }
}
