//
//  OrganizationGridView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct OrganizationGridView: View {
    
    var onTap: ()->Void = {}
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    var activeColor: Color = .AppPrimary3.opacity(0.55)
    
    var body: some View {
        let gridItems = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(0..<100) {idx in
                    let showData: Bool = idx < recordCollectionViewModel.organizations.count
                    Circle()
                        .foregroundColor(showData ? activeColor : .AppSecondaryLight)
                        .opacity(showData ? 0.9: 0.05)
                        .overlay {
                            Text(showData ? recordCollectionViewModel.organizations[idx].name! : "")
                                .font(.largeTitle)
                                .scaledToFit()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(Color.AppTextLight)
                                .opacity(0.66)
                        }
                        .shadow(color: activeColor, radius: showData ? 5 : 0)
                        .padding(7)
                        .onTapGesture {
                            guard(showData) else {return}
                            recordCollectionViewModel.focusedOrganization = recordCollectionViewModel.organizations[idx]
                            onTap()
                        }
                }
            }
        }
    }
}

struct OrganizationGridView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationGridView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
