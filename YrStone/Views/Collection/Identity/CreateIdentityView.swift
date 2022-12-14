//
//  CreateIdentityView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct CreateIdentityView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var inputAvatarIndex: Int = 1
    @State var inputIdentityName: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    @State var showSelectAvatar = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create Identity")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.AppText)
                    .padding(.bottom)
                    .padding()
                
                Avatar(inputAvatarIndex: $inputAvatarIndex)
                
                RoundedIconTextField(value: $inputIdentityName, icon: Image(systemName: "person.fill"), label: "Name", height: Design.TextField.MainHeight)
                    .padding(.vertical)
                    .frame(maxWidth: Design.TextField.MaxWidth)
                Button("Save") {
                    guard (inputIdentityName.isNotEmpty) else {
                        return
                    }
                    let info = IdentityInfo(name: inputIdentityName, avatarIndex: inputAvatarIndex)
                    recordCollectionViewModel.createIdentity(info: info)
                    
                    dismiss()
                }
                .buttonStyle(PrimaryButton())
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.AppCanvas)
    }
}

struct CreateIdentityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIdentityView()
    }
}
