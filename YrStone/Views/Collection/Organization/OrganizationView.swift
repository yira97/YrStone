//
//  OrganizationView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct OrganizationView: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    @State var showCreateOrganization: Bool = false
    @State var showDetail: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        OrganizationGroupView(
            displayMode: .Card,
            afterTap: {
                showDetail = true
            }
        )
        .padding(.horizontal)
        .background(LinearGradient.ForOrganization)
        .navigationTitle("Organizations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{
                    showCreateOrganization = true
                }) {
                    HStack(spacing: 0){
                        Image(systemName: "plus")
                        Image.OrganizationIcon
                            .font(.footnote)
                    }
                }
                .buttonStyle(ToolBarButton())
            }
        }
        .navigationDestination(isPresented: $showCreateOrganization) {
            CreateOrganizationView()
        }
        .sheet(isPresented: $showDetail) {
            OrganizationDetailView()
                .presentationDetents([.medium])
        }
        .onAppear {
            recordCollectionViewModel.clearFocus()
            debugPrint("OrganizationView appear")
        }
        .onDisappear {
            recordCollectionViewModel.clearFocus()
        }
    }
}

struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
