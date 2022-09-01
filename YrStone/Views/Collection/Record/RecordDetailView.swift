//
//  RecordDetailView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI

struct RecordDetailView: View {
    var record: RecordInfo
    
    @EnvironmentObject var vm: RecordCollectionViewModel
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var editingMode: Bool = false
    @State private var inputExtras = [RecordInfo.ExtraContent]()
    
    var changed: Bool {
        get {
            inputUsername != record.username ||
            inputPassword != record.password ||
            inputExtras.filter({$0.desc.isNotEmpty && $0.content.isNotEmpty}).displaySorting() != record.extraContents.displaySorting()
        }
    }
    
    var body: some View {
        let organizationName = record.organization?.name ?? "Indivisual"
        let identityName = record.Identity?.name ?? "Anonymous"
        
        VStack {
            Text(organizationName)
                .font(.largeTitle)
                .bold()
                .padding()
            HStack {
                Image.IdentityIcon
                Text(identityName)
            }
            .foregroundColor(.gray)
            
            Divider()
            VStack {
                RoundedIconTextField(
                    value: $inputUsername,
                    icon: Image(systemName: "person.fill"),
                    label: "Username",
                    editable: editingMode
                )
                .padding(.bottom)
                RoundedIconTextField(
                    value: $inputPassword,
                    icon: Image(systemName: "key.fill"),
                    label: "Password",
                    editable: editingMode
                )
                .textContentType(.password)
            }
            .padding(.vertical)
            Text("Extra Info")
                .font(.title2)
                .bold()
                .foregroundColor(.AppPrimary5)
            ScrollView {
                VStack {
                    ForEach(Array(inputExtras.enumerated()), id: \.offset) {index, offset in
                        HStack {
                            RoundedIconTextField(
                                value: $inputExtras[index].content,
                                icon: Image(systemName: "doc.plaintext.fill"),
                                label: "Content",
                                editable: editingMode,
                                height: 50,
                                color: record.extraContents.count > index && record.extraContents[index].content == inputExtras[index].content ? Color.AppPrimary5 : Color.AppPrimary2
                            )
                            
                            RoundedIconTextField(
                                value: $inputExtras[index].desc,
                                icon: Image(systemName: "bookmark.fill"),
                                label: "Description",
                                editable: editingMode,
                                height: 50,
                                color: record.extraContents.count > index && record.extraContents[index].desc == inputExtras[index].desc ? Color.AppPrimary5 : Color.AppPrimary2
                            )
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.AppCardBackground)
                )
            }
            HStack {
                Spacer()
                if (editingMode) {
                    Button("Add Field") {
                        guard (inputExtras.valid()) else {
                            return
                        }
                        inputExtras.append(RecordInfo.ExtraContent(content: "", desc:""))
                    }
                    .buttonStyle(AddSthButton())
                    .padding()
                }
            }
        }
        .navigationTitle("Record Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    inputExtras = inputExtras.filter({$0.desc.isNotEmpty && $0.content.isNotEmpty})
                    if (editingMode && changed) {
                        var updateInfo = record
                        updateInfo.username = inputUsername
                        updateInfo.password = inputPassword
                        updateInfo.extraContents = inputExtras.filter({$0.desc.isNotEmpty && $0.content.isNotEmpty})
                        vm.updateRecord(info: updateInfo)
                    }
                    editingMode = !editingMode
                }) {
                    let icon = editingMode ? Image(systemName: "checkmark") : Image(systemName: "pencil")
                    icon
                }
                .buttonStyle(ToolBarButton(rotate: editingMode))
            }
        }
        .onAppear {
            inputUsername = record.username
            inputPassword = record.password
            inputExtras = record.extraContents
        }
        .padding()
    }
}


struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView(record: RecordInfo.Random())
    }
}
