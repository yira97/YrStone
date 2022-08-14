//
//  CreateRecordView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/23.
//

import SwiftUI

struct CreateRecordView: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var inputUsername = ""
    @State private var inputPassword = ""
    @State private var inputExtras = [RecordInfo.ExtraContent]()
    
    @State private var showIdentitySelection = false
    @State private var showOrganizationSelection = false
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Create Record")
                .font(.title)
                .bold()
                .foregroundColor(.AppPrimary5)
                .padding()
            ScrollView {
                VStack (alignment: .center) {
                    
                    RoundedIconTextField(value: $inputUsername, icon: Image(systemName: "person.fill"), label: "Username",editable: true)
                        .padding(.bottom)
                    RoundedIconTextField(value: $inputPassword, icon: Image(systemName: "key.fill"), label: "Password")
                        .padding(.bottom)
                    VStack {
                        if (inputExtras.count > 0) {
                            Text("Extra Info")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.AppPrimary5)
                                .padding()
                        }
                        ForEach(Array(inputExtras.enumerated()), id: \.offset) {index, offset in
                            HStack {
                                RoundedIconTextField(
                                    value: $inputExtras[index].content,
                                    icon: Image(systemName: "doc.plaintext.fill"),
                                    label: "Content",
                                    height: 50
                                )
                                
                                RoundedIconTextField(
                                    value: $inputExtras[index].desc,
                                    icon: Image(systemName: "bookmark.fill"),
                                    label: "Description",
                                    height: 50
                                )
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.AppBackgroundLight)
                    )
                    HStack {
                        Spacer()
                        Button("Add Field") {
                            if let extra = inputExtras.last {
                                guard(extra.content.isNotEmpty && extra.desc.isNotEmpty) else {
                                    return
                                }
                            }
                            
                            inputExtras.append(RecordInfo.ExtraContent(content: "", desc:""))
                        }
                        .buttonStyle(AddSthButton())
                    }
                    
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Select an")
                                .opacity(0.85)
                            Text("Identity")
                        }
                        .font(.title3)
                        .bold()
                        .foregroundColor(.AppPrimary5)
                        Text(recordCollectionViewModel.focusedIdentity?.name ?? "")
                            .frame(width:120)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.AppPrimary2)
                            .padding(.horizontal)
                            .padding(.trailing, 20)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50, style: .continuous)
                                    .foregroundColor(.AppBackgroundLight)
                            )
                            .overlay(
                                ReselectButton(action: {
                                    showIdentitySelection = true
                                }, dimension: 50),alignment: .trailing
                            )
                        
                        HStack {
                            Text("Select an")
                                .opacity(0.85)
                            Text("Organization")
                        }
                        .font(.title3)
                        .bold()
                        .foregroundColor(.AppPrimary5)
                        .padding(.top)
                        ZStack(alignment:.trailing) {
                            Text(recordCollectionViewModel.focusedOrganization?.name ?? "")
                                .frame(width: 120)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.AppPrimary2)
                                .padding(.horizontal)
                                .padding(.trailing, 20)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                                        .foregroundColor(.AppBackgroundLight)
                                )
                            ReselectButton(action: {
                                showOrganizationSelection = true
                            }, dimension: 50)
                        }
                    }
                    .padding()
                    Divider()
                    Button("Save") {
                        guard (inputUsername.isNotEmpty && inputPassword.isNotEmpty) else {
                            return
                        }
                        guard (!inputExtras.contains(where: { extra in
                            extra.desc.isEmpty || extra.content.isEmpty
                        })) else {
                            return
                        }
                        let info = RecordInfo(username: inputUsername, password: inputPassword, extraContents: inputExtras)
                        recordCollectionViewModel.createRecord(info: info, identityName: recordCollectionViewModel.focusedIdentity?.name, organizationName:     recordCollectionViewModel.focusedOrganization?.name)
                        dismiss()
                    }
                    .buttonStyle(PrimaryButton())
                }
                .padding([.horizontal])
            }
            .sheet(isPresented: $showIdentitySelection) {
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 40)
                        .foregroundColor(Color.AppPrimary3)
                        .opacity(0.7)
                        .overlay(
                            Image(systemName: "xmark")
                                .foregroundColor(Color.AppTextDark)
                        )
                        .onTapGesture {
                            recordCollectionViewModel.focusedIdentity = nil
                            showIdentitySelection = false
                        }
                    IdentityListView(onTap: {
                        showIdentitySelection = false
                    })
                }
                .padding()
                .background(Color.AppPrimary5)
                .presentationDetents([.medium])
            }
            .sheet(isPresented: $showOrganizationSelection) {
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 40)
                        .foregroundColor(Color.AppPrimary3)
                        .opacity(0.7)
                        .overlay(
                            Image(systemName: "xmark")
                                .foregroundColor(Color.AppTextDark)
                        )
                        .onTapGesture {
                            recordCollectionViewModel.focusedOrganization = nil
                            showOrganizationSelection = false
                        }
                    OrganizationGridView(onTap: {
                        showOrganizationSelection = false
                    })
                }
                .padding()
                .background(Color.AppPrimary5)
                .presentationDetents([.medium])
            }
        }
    }
}

struct CreateRecordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecordView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
