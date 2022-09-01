//
//  IdentityGroupView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct IdentityGroupView<S : Shape>: View {
    enum DisplayMode {
        case Grid, List
    }
    
    @EnvironmentObject var vm: RecordCollectionViewModel
    
    var onTap: ()->Void = {}
    var displayMode: DisplayMode = DisplayMode.Grid
    var shape: S
    
    var activeFrontColor = Color.white
    var activeBackColor = Color.AppPrimary5.opacity(0.6)
    var inactiveBackColor = Color.white.opacity(0.2)
    
    
    @ViewBuilder
    func cell(_ idx: Int) -> some View {
        let hasData = idx < vm.identities.count
        if (hasData) {
            activeBackColor
                .clipShape(shape)
                .overlay(
                    Text( hasData ? vm.identities[idx].name! : "" )
                        .font(.title2)
                        .foregroundColor(activeFrontColor.opacity(0.75))
                )
                .shadow(color: activeBackColor, radius: 5)
                .onTapGesture {
                    vm.focusedIdentity = vm.identities[idx]
                    onTap()
                }
        } else {
            inactiveBackColor
                .clipShape(shape)
        }
    }
    
    var body: some View {
        ScrollView {
            let showCount = vm.identities.count + (displayMode == .List ? 3 : 12)
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

struct IdentityGroupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IdentityGroupView(displayMode: .Grid,shape: Circle())
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
            IdentityGroupView(displayMode: .List, shape: RoundedRectangle(cornerRadius: 20))
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
        }.background(Color.black)
    }
}
