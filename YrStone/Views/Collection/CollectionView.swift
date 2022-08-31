//
//  CollectionView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/22.
//

import SwiftUI

struct CollectionView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showCreateRecordView = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Categories")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.AppText(colorScheme))
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            NavigationLink(destination: IdentityView()) {
                                CategoryCardView(background: LinearGradient.ForIdentity, text: "Identities", icon: Image.IdentityIcon)
                            }
                            NavigationLink(destination: OrganizationView()) {
                                CategoryCardView(background: LinearGradient.ForOrganization, text: "Organizations", icon: Image.OrganizationIcon)
                            }
                        }
                        .shadow(radius: 5,x:0,y:5)
                        .padding([.horizontal,.bottom])
                        
                    }
                    
                    Text("Activities")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.AppText(colorScheme))
                    RecentRecordList()
                        .shadow(color: Color.AppPrimary5.opacity(0.2), radius: 10, x:0, y:5)
                        .padding([.horizontal,.bottom])
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .dark ? Color.AppPrimary5.opacity(0.7) : Color.AppPrimary5.opacity(0.1))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        showCreateRecordView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(ToolBarButton())
                }
            }
            .navigationDestination(isPresented: $showCreateRecordView) {
                CreateRecordView()
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
