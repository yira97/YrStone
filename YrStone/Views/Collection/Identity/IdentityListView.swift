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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10) {idx in
                    let showData: Bool = idx < recordCollectionViewModel.identities.count
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.AppBackgroundLight)
                        .frame(height:80)
                        .opacity(showData ? 0.7 : 0.2)
                        .overlay(
                            showData ? Text( recordCollectionViewModel.identities[idx].name!)
                                .font(.title2)
                                .foregroundColor(Color.AppTextDark) : Text("")
                        )
                        .padding(5)
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
