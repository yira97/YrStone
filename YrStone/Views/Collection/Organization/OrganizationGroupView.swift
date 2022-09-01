//
//  OrganizationGroupView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct OrganizationGroupView<S : Shape>: View {
    enum DisplayMode {
        case Grid, List
    }
    
    @EnvironmentObject var vm: RecordCollectionViewModel
    
    var onTap: ()->Void = {}
    var displayMode: DisplayMode = DisplayMode.Grid
    var shape: S
    
    var activeFrontColor = Color.AppPrimary5
    var activeBackColor = Color.white.opacity(0.6)
    var inactiveBackColor = Color.white.opacity(0.2)
    
    
    @ViewBuilder
    func cell(_ idx: Int) -> some View {
        let hasData = idx < vm.organizations.count
        if (hasData) {
            activeBackColor
                .clipShape(shape)
                .overlay(
                    Text( hasData ? vm.organizations[idx].name! : "" )
                        .font(.title2)
                        .foregroundColor(activeFrontColor.opacity(0.75))
                )
                .shadow(color: activeBackColor, radius: 5)
                .onTapGesture {
                    vm.focusedOrganization = vm.organizations[idx]
                    onTap()
                }
        } else {
            inactiveBackColor
                .clipShape(shape)
        }
    }
    
    var body: some View {
        ScrollView {
            let showCount = vm.organizations.count + (displayMode == .List ? 3 : 12)
            if (displayMode == .Grid) {
                let gridItems = [GridItem(.adaptive(minimum: 80, maximum: 150))]
                LazyVGrid(columns: gridItems) {
                    ForEach(0..<showCount, id: \.self) {idx in
                        cell(idx)
                            .aspectRatio(1, contentMode: .fill)
                            .padding(8)
                    }
                }
            } else {
                LazyVStack {
                    ForEach(0..<showCount, id: \.self) {idx in
                        cell(idx)
                            .frame(height: 80)
                            .padding(8)
                    }
                }
            }
        }
    }
}
