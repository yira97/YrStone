//
//  OrganizationGroupView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct OrganizationGroupView: View {
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
    static let  OrganizationBackgroundOpacity = 0.4
    
    init(
        displayMode: DisplayMode = DisplayMode.Card,
        afterTap: @escaping () -> Void = {},
        activeFrontColor: Color =  Color.AppPrimary2,
        activeBackColor: Color  = Color.white.opacity(0.7),
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
        let hasData = idx < vm.organizations.count
        ZStack {
            hasData ? activeBackColor : inactiveBackColor
            if (hasData) {
                GeometryReader { geo in
                    AutoColoredBadge(label:vm.organizations[idx].name!, width: geo.maxWidth)
                        .blur(radius: 1)
                        .opacity(Self.OrganizationBackgroundOpacity)
                    HStack {
                        VStack(alignment:.leading) {
                            Text("NAME")
                                .font(.caption)
                                .foregroundColor(Color.AppText)
                            Text(vm.organizations[idx].name!)
                                .font(.title)
                                .scaledToFit()
                                .minimumScaleFactor(0.01)
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                .foregroundColor(activeFrontColor)
            }
        }
        .onTapGesture {
            guard(hasData) else {return}
            vm.focusedOrganization = vm.organizations[idx]
            afterTap()
        }
        .aspectRatio(aspectRatio,contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: activeBackColor.opacity(0.5), radius: hasData ? 10 : 0)
    }
    
    @ViewBuilder
    func icon(_ idx: Int) -> some View {
        let hasData = idx < vm.organizations.count
        ZStack {
            hasData ? activeBackColor : inactiveBackColor
            VStack {
                if (hasData) {
                    AutoColoredBadge(
                        label:vm.organizations[idx].name!,
                        width: minGridWidth * 0.5
                    )
                    .opacity(Self.OrganizationBackgroundOpacity)
                    .clipShape(Circle())
                        
                    Text(hasData ? vm.organizations[idx].name! : "")
                        .foregroundColor(activeFrontColor)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .padding(.horizontal)
                }
            }
        }
        .onTapGesture {
            guard(hasData) else {return}
            vm.focusedOrganization = vm.organizations[idx]
            afterTap()
        }
        .aspectRatio(aspectRatio,contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: activeBackColor.opacity(0.5), radius: hasData ? 3 : 0)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minGridWidth, maximum: minGridWidth * 2))]) {
                ForEach(0..<vm.organizations.count + blankSlot, id: \.self) {idx in
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
            debugPrint("OrganizationGroupView appear")
        }
    }
}

struct OrganizationGroupView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationGroupView()
            .background(Color.black)
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
