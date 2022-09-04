//
//  IdentityGroupView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct IdentityGroupView: View {
    enum DisplayMode {
        case Card, Icon
    }
    
    @EnvironmentObject var vm: RecordCollectionViewModel
    
    var afterTap: ()->Void
    
    var displayMode: DisplayMode
    
    // width / height
    var aspectRatio: CGFloat
    var minGridWidth: CGFloat
    var blankSlot: Int
    
    var activeFrontColor : Color
    var activeBackColor : Color
    var inactiveBackColor : Color
    
    init(
        displayMode: DisplayMode = DisplayMode.Card,
        afterTap: @escaping () -> Void = {},
        activeFrontColor: Color =  Color.white,
        activeBackColor: Color  = Color.AppPrimary5.opacity(0.6),
        inactiveBackColor: Color = Color.white.opacity(0.2)
    ) {
        self.displayMode = displayMode
        if (displayMode == .Card) {
            self.aspectRatio = 1.75
            self.minGridWidth = 240
            self.blankSlot = 6
        } else {
            self.aspectRatio = 1
            self.minGridWidth = 120
            self.blankSlot = 12
        }
        
        self.afterTap = afterTap
        
        self.activeFrontColor = activeFrontColor
        self.activeBackColor = activeBackColor
        self.inactiveBackColor = inactiveBackColor
    }
    
    @ViewBuilder
    func card(_ idx: Int) -> some View {
        let hasData = idx < vm.identities.count
        ZStack {
            hasData ? activeBackColor : inactiveBackColor
            if (hasData) {
                GeometryReader { geo in
                    HStack {
                        AvatarBase(index: Int(vm.identities[idx].avatarIndex), width: minGridWidth/aspectRatio * 0.6)
                            .clipShape(Circle())
                            .padding()
                            .padding(.leading)
                        VStack(alignment: .leading) {
                            Text("NAME")
                                .font(.caption)
                            // capitalize each word in the name field
                            Text(vm.identities[idx].name!.capitalized)
                                .font(.title2)
                                .scaledToFit()
                                .minimumScaleFactor(0.01)
                        }
                        .padding(.trailing)
                        Spacer()
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                .foregroundColor(activeFrontColor)
            }
        }
        .onTapGesture {
            guard(hasData) else {return}
            vm.focusedIdentity = vm.identities[idx]
            afterTap()
        }
        .aspectRatio(aspectRatio,contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: activeBackColor, radius: hasData ? 10 : 0)
    }
    
    @ViewBuilder
    func icon(_ idx: Int) -> some View {
        let hasData = idx < vm.identities.count
        ZStack {
            hasData ? activeBackColor : inactiveBackColor
            VStack {
                if (hasData) {
                    AvatarBase(index: Int(vm.identities[idx].avatarIndex),width: minGridWidth * 0.5)
                        .clipShape(Circle())
                }
                Text(hasData ? vm.identities[idx].name! : "")
                    .foregroundColor(activeFrontColor)
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .padding(.horizontal)
            }
        }
        .onTapGesture {
            guard(hasData) else {return}
            vm.focusedIdentity = vm.identities[idx]
            afterTap()
        }
        .aspectRatio(aspectRatio,contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: activeBackColor, radius: hasData ? 3 : 0)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minGridWidth, maximum: minGridWidth * 2))]) {
                ForEach(0..<vm.identities.count + blankSlot, id: \.self) {idx in
                    if (displayMode == .Card) {
                        card(idx)
                    } else {
                        icon(idx)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            debugPrint("IdentityGroupView appear")
        }
    }
}

struct IdentityGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityGroupView()
            .background(Color.black)
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
