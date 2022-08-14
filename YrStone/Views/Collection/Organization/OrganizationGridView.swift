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
    
    var body: some View {
        let gridItems = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
        
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(0..<100) {idx in
                    let showData: Bool = idx < recordCollectionViewModel.organizations.count
                    Circle()
                        .foregroundColor(.AppBackgroundLight)
                        .opacity(showData ? 0.7: 0.2)
                        .overlay {
                            Text(showData ? recordCollectionViewModel.organizations[idx].name! : "")
                        }
                        .padding(5)
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
