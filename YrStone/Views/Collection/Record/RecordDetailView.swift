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
    @State private var showIdentityPage = false
    @State private var showOrganizationPage = false
    
    var changed: Bool {
        get {
            inputUsername != record.username ||
            inputPassword != record.password ||
            inputExtras.displaySorting() != record.extraContents.displaySorting() ||
            vm.focusedIdentity != record.identity?.managedEntity ||
            vm.focusedOrganization != record.organization?.managedEntity
        }
    }
    
    var body: some View {
        let organizationName = vm.focusedOrganization?.name ?? "Indivisual"
        let identityName = vm.focusedIdentity?.name ?? "Anonymous"
        
        ScrollView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    AutoColoredBadge(label: organizationName, width: .infinity, height: 250)
                        .opacity(OrganizationGroupView.OrganizationBackgroundOpacity)
                    HStack {
                        AvatarBase(index: Int(vm.focusedIdentity?.avatarIndex ?? 1), width: 40)
                            .clipShape(Circle())
                        Text(identityName)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                .foregroundColor(.gray)
                
                VStack {
                    RoundedIconTextField(
                        value: $inputUsername,
                        icon: Image(systemName: "person.fill"),
                        label: "Username",
                        editable: editingMode,
                        height: Design.TextField.MainHeight
                    )
                    .padding(.bottom)
                    RoundedIconTextField(
                        value: $inputPassword,
                        icon: Image(systemName: "key.fill"),
                        label: "Password",
                        editable: editingMode,
                        height: Design.TextField.MainHeight
                    )
                    .textContentType(.password)
                }
                .padding(.vertical)
                .frame(maxWidth: Design.TextField.MaxWidth)
                
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
                                    height: Design.TextField.SubHeight,
                                    color: record.extraContents.count > index && record.extraContents[index].content == inputExtras[index].content ? Color.AppPrimary5 : Color.AppPrimary2
                                )
                                
                                RoundedIconTextField(
                                    value: $inputExtras[index].desc,
                                    icon: Image(systemName: "bookmark.fill"),
                                    label: "Description",
                                    editable: editingMode,
                                    height: Design.TextField.SubHeight,
                                    color: record.extraContents.count > index && record.extraContents[index].desc == inputExtras[index].desc ? Color.AppPrimary5 : Color.AppPrimary2
                                )
                            }
                            .frame(maxWidth: Design.TextField.MaxWidth * 2)
                            .padding(.horizontal)
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
                Spacer()
                if (editingMode) {
                    HStack(spacing:30) {
                        Button("Change Identity") {
                            showIdentityPage = true
                        }
                        
                        Button("Change Organization") {
                            showOrganizationPage = true
                        }
                    }
                    .padding()
                }
            }
        }
        // Identity Page
        .sheet(isPresented: $showIdentityPage) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 40)
                    .foregroundColor(Color.AppCardBackground)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(Color.AppText)
                    )
                    .onTapGesture {
                        vm.focusedIdentity = nil
                        showIdentityPage = false
                    }
                IdentityGroupView(
                    displayMode: .Icon,
                    afterTap: {
                        showIdentityPage = false
                    }
                )
            }
            .padding()
            .background(LinearGradient.ForIdentity)
            .presentationDetents([.medium])
        }
        // Organization Page
        .sheet(isPresented: $showOrganizationPage) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 40)
                    .foregroundColor(Color.AppCardBackground)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(Color.AppText)
                    )
                    .onTapGesture {
                        vm.focusedOrganization = nil
                        showOrganizationPage = false
                    }
                OrganizationGroupView (
                    displayMode: .Icon,
                    afterTap: {
                        showOrganizationPage = false
                    }
                )
            }
            .padding()
            .background(LinearGradient.ForOrganization)
            .presentationDetents([.medium])
        }
        .navigationTitle("Record Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    inputExtras = inputExtras.filter({$0.desc.isNotEmpty && $0.content.isNotEmpty})
                    if (editingMode && changed) {
                        var updateInfo = record
                        
                        // for simple field just set to the new value
                        updateInfo.username = inputUsername
                        updateInfo.password = inputPassword
                        
                        // for relation field but not optional, just set to the new value
                        updateInfo.extraContents = inputExtras.filter({$0.desc.isNotEmpty && $0.content.isNotEmpty})
                        
                        // for relation field with optional, up
                        updateInfo.organization = vm.focusedOrganization != nil ?  OrganizationInfo.fromYrOrganizationEntity(entity: vm.focusedOrganization!) : nil
                        updateInfo.identity = vm.focusedIdentity != nil ? IdentityInfo.fromYrIdentityEntity(entity: vm.focusedIdentity!) : nil
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
            
            vm.focusedIdentity = record.identity?.managedEntity
            vm.focusedOrganization = record.organization?.managedEntity
        }
        .onDisappear {
            vm.clearFocus()
        }
    }
}


struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView(record: RecordInfo.Random())
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
