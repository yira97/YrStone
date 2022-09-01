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
    
    func resetFocus() {
        recordCollectionViewModel.focusedOrganization = nil
    }
    
    var body: some View {
        OrganizationGroupView(
            onTap: {
                showDetail = true
            },
            displayMode: .List,
            shape: RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal)
        // TODO: deleting the padding will cause the navigationBarTitleDisplayMode change when scrolling which is unexpected.
        .padding(.vertical, 1)
        .background(LinearGradient.ForOrganization)
        .navigationTitle("Organizations")
        .navigationBarTitleDisplayMode(.large)
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
            resetFocus()
        }
        .onDisappear {
            resetFocus()
        }
    }
}

struct OrganizationView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView()
    }
}
