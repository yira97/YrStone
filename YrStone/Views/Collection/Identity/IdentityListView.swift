//
//  IdentityListView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct IdentityListView: View {
    var onTap: ()->Void = {}
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    var activeColor: Color = Color.AppPrimary5.opacity(0.6)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10) {idx in
                    let showData: Bool = idx < recordCollectionViewModel.identities.count
                    let shape = RoundedRectangle(cornerRadius: 20)
                    
                    ZStack {
                        if (showData) {
                            activeColor
                        } else {
                            Color.AppSecondaryLight.opacity(0.1)
                        }
                    }
                        .frame(height:80)
                        .clipShape(shape)
                        .overlay(
                            Text( showData ? recordCollectionViewModel.identities[idx].name! : "" )
                                .font(.title2)
                                .foregroundColor(Color.AppTextLight.opacity(0.75))
                        )
                        .shadow(color: activeColor, radius: showData ? 5 : 0)
                        .padding(7)
                        .onTapGesture {
                            guard(showData) else {return}
                            recordCollectionViewModel.focusedIdentity = recordCollectionViewModel.identities[idx]
                            onTap()
                        }
                }
            }
            
        }
    }
}

struct IdentityListView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityListView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
