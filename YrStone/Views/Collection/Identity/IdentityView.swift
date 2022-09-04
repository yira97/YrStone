//
//  IdentityView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct IdentityView: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    @State var showCreatePage: Bool = false
    @State var showDetailPage: Bool = false
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            IdentityGroupView(
                afterTap: {
                    showDetailPage = true
                }
            )
        }
        .padding(.horizontal)
        // TODO: deleting the padding will cause the navigationBarTitleDisplayMode change when scrolling which is unexpected.
        //.padding(.vertical,1)
        .background(
            LinearGradient.ForIdentity
        )
        .navigationTitle("Identities")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{ showCreatePage = true }) {
                    HStack(spacing: 0){
                        Image(systemName: "plus")
                        Image.IdentityIcon
                            .font(.footnote)
                    }
                }
                .buttonStyle(ToolBarButton())
            }
        }
        .sheet(isPresented: $showDetailPage) {
            IdentityDetailView()
                .presentationDetents([.medium])
        }
        .navigationDestination(isPresented: $showCreatePage) {
            CreateIdentityView()
        }
        .onAppear() {
            recordCollectionViewModel.clearFocus()
            debugPrint("IdentityView appear")
        }
        .onDisappear {
            recordCollectionViewModel.clearFocus()
        }
    }
}

struct IdentityView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
