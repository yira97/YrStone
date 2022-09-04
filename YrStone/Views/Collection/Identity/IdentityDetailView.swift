//
//  IdentityDetailView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct IdentityDetailView: View {
    @EnvironmentObject var vm: RecordCollectionViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var inputName: String = ""
    @State var inputAvatarIndex: Int = 1
    @State var editMode = false
    
    func isChanged(_ info: IdentityInfo)-> Bool {
        inputName != info.name ||
        inputAvatarIndex != info.avatarIndex
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if (vm.focusedIdentity == nil) {
                Text("something wrong")
            } else {
                VStack {
                    Text("Detail")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.AppText)
                        .padding()
                    Divider()
                    Avatar(inputAvatarIndex: $inputAvatarIndex, editable: editMode)
                    RoundedIconTextField(
                        value: $inputName,
                        icon: Image.IdentityIcon,
                        label: "Name",
                        editable: editMode,
                        height: Design.TextField.MainHeight,
                        color: vm.focusedIdentity!.name == inputName ? .AppPrimary5 : .AppPrimary2
                    )
                    .frame(maxWidth: Design.TextField.MaxWidth)
                        .padding()
                    Spacer()
                }
                .padding()
                Button(action: {
                    if (editMode) {
                        let originalInfo = IdentityInfo.fromYrIdentityEntity(entity: vm.focusedIdentity!)
                        if (isChanged(originalInfo)) {
                            var updateInfo = originalInfo
                            updateInfo.name = inputName
                            updateInfo.avatarIndex = inputAvatarIndex
                            vm.updateIdentity(info: updateInfo)
                        }
                    }
                    editMode = !editMode
                }) {
                    Image(systemName: editMode ? "checkmark" : "pencil")
                }
                .buttonStyle(ToolBarButton(rotate: editMode))
                .padding()
            }
        }
        .onAppear{
            if let identity = vm.focusedIdentity {
                inputName = identity.name!
                inputAvatarIndex = Int(identity.avatarIndex)
            }
            debugPrint("IdentityDetailView appear")
        }
    }
}

struct IdentityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityDetailView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
