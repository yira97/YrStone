//
//  CollectionView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/22.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    @State private var showCreateRecordView = false
    @State private var showSearchBar = false
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Categories")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.AppText)
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
                            .foregroundColor(Color.AppText)
                        RecentRecordList()
                            .shadow(color: Color.AppPrimary5.opacity(0.2), radius: 10, x:0, y:5)
                            .padding([.horizontal,.bottom])
                    }
                }
                HStack {
                    Button(action:{showSearchBar = !showSearchBar}) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height:25)
                    }
                    .buttonStyle(RoundButton(color: showSearchBar ? .AppPrimary3 : .AppPrimary2))
                    .shadow(color: showSearchBar ? .AppPrimary3 : .AppPrimary2 , radius: 5)
                    .animation(.easeInOut, value: showSearchBar)
                    .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.AppCanvas)
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
