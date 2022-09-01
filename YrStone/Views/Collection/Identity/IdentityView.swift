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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func resetFocus() {
        recordCollectionViewModel.focusedIdentity = nil
    }
    
    var body: some View {
        IdentityGroupView(
            onTap: {
                showDetailPage = true
            },
            shape: RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal)
        // TODO: deleting the padding will cause the navigationBarTitleDisplayMode change when scrolling which is unexpected.
        .padding(.vertical,1)
        .background(
            LinearGradient.ForIdentity
        )
        .navigationTitle("Identities")
        .navigationBarTitleDisplayMode(.large)
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
            resetFocus()
        }
        .onDisappear {
            resetFocus()
        }
    }
}

struct IdentityView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
