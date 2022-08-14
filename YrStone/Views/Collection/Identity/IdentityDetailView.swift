//
//  IdentityDetailView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct IdentityDetailView: View {
    @EnvironmentObject var vm: RecordCollectionViewModel
    @State var inputName: String = ""
    @State var editMode = false
    
    func getChanged(info: IdentityInfo)-> Bool {
        inputName != info.name
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
                        .foregroundColor(Color.AppPrimary5)
                        .padding()
                    Divider()
                    RoundedIconTextField(value: $inputName, icon: Image.IdentityIcon, label: "Name", editable: editMode, color: vm.focusedIdentity!.name == inputName ? .AppPrimary5 : .AppPrimary2)
                        .padding()
                    Spacer()
                }
                Button(action: {
                    if (editMode) {
                        let originalInfo = IdentityInfo.fromYrIdentityEntity(entity: vm.focusedIdentity!)
                        if (getChanged(info: originalInfo)) {
                            var updateInfo = originalInfo
                            updateInfo.name = inputName
                            vm.updateIdentity(info: updateInfo)
                        }
                    }
                    editMode = !editMode
                }) {
                    Image(systemName: editMode ? "checkmark" : "pencil")
                }
                .buttonStyle(ToolBarButton(revColor: editMode))
                .padding()
            }
        }
        .onAppear{
            if let name = vm.focusedIdentity?.name {
                inputName = name
            }
        }
    }
}

struct IdentityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IdentityDetailView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
