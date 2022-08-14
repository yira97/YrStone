//
//  CreateIdentityView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct CreateIdentityView: View {
    @State var inputIdentityName: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create Identity")
                    .font(.title)
                    .bold()
                    .foregroundColor(.AppPrimary5)
                    .padding(.bottom)
                    .padding()
                RoundedIconTextField(value: $inputIdentityName, icon: Image(systemName: "person.fill"), label: "Name")
                    .padding(.bottom)
                Button("Save") {
                    guard (inputIdentityName.isNotEmpty) else {
                        return
                    }
                    let info = IdentityInfo(name: inputIdentityName)
                    recordCollectionViewModel.createIdentity(info: info)
                    
                    dismiss()
                }
                .buttonStyle(PrimaryButton())
            }
            .padding()
        }
    }
}

struct CreateIdentityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIdentityView()
    }
}