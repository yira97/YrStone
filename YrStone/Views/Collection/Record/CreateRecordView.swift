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
    
    @ViewBuilder
    func pleaseSelect(title: String, value: String, action: @escaping () -> Void) -> some View {
        HStack {
            Text("Select an")
                .fontWeight(.light)
            Text(title)
        }
        .font(.title3)
        .foregroundColor(.AppText)
        Text(value)
            .frame(width:120)
            .font(.title3)
            .bold()
            .foregroundColor(.AppPrimary2)
            .padding(.horizontal)
            .padding(.trailing, 20)
            .padding()
            .frame(height:50)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .foregroundColor(.AppCardBackground)
            )
            .overlay(
                Button(action: action){
                    Image.RefreshIcon
                        .resizable()
                        .scaledToFit()
                }
                    .buttonStyle(RoundButton())
                ,alignment: .trailing
            )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create Record")
                    .font(.title)
                    .bold()
                    .foregroundColor(.AppText)
                    .padding()
                RoundedIconTextField(
                    value: $inputUsername,
                    icon: Image(systemName: "person.fill"),
                    label: "Username",
                    editable: true
                )
                .padding(.bottom)
                RoundedIconTextField(
                    value: $inputPassword,
                    icon: Image(systemName: "key.fill"),
                    label: "Password"
                )
                .padding(.bottom)
                VStack {
                    if (inputExtras.count > 0) {
                        Text("Extra Information")
                            .bold()
                            .foregroundColor(.AppPrimary5)
                            .opacity(0.8)
                            .padding(.top)
                        Divider()
                    }
                    ForEach(Array(inputExtras.enumerated()), id: \.offset) {index, offset in
                        HStack {
                            RoundedIconTextField(
                                value: $inputExtras[index].content,
                                icon: Image(systemName: "doc.plaintext.fill"),
                                label: "Content",
                                height: 40
                            )
                            
                            RoundedIconTextField(
                                value: $inputExtras[index].desc,
                                icon: Image(systemName: "bookmark.fill"),
                                label: "Description",
                                height: 40
                            )
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color.AppCardBackground)
                )
                HStack {
                    Spacer()
                    Button("Add Field") {
                        guard inputExtras.valid() else {
                            return
                        }
                        inputExtras.append(RecordInfo.ExtraContent(content: "", desc:""))
                    }
                    .buttonStyle(AddSthButton())
                }
                
                Divider()
                
                VStack {
                    pleaseSelect(
                        title: "Identity",
                        value: recordCollectionViewModel.focusedIdentity?.name ?? "",
                        action: { showIdentitySelection = true }
                    )
                    pleaseSelect(
                        title: "Organization",
                        value: recordCollectionViewModel.focusedOrganization?.name ?? "",
                        action: { showOrganizationSelection = true }
                    )
                }
                .padding()
                Divider()
                Button("Save") {
                    guard (
                        inputUsername.isNotEmpty &&
                        inputPassword.isNotEmpty &&
                        inputExtras.valid()
                    ) else {
                        return
                    }
                    let info = RecordInfo(
                        username: inputUsername,
                        password: inputPassword,
                        extraContents: inputExtras
                    )
                    recordCollectionViewModel.createRecord(
                        info: info,
                        identityName: recordCollectionViewModel.focusedIdentity?.name,
                        organizationName:     recordCollectionViewModel.focusedOrganization?.name
                    )
                    dismiss()
                }
                .buttonStyle(PrimaryButton())
            }
            .padding([.horizontal])
        }
        // Identity Page
        .sheet(isPresented: $showIdentitySelection) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 40)
                    .foregroundColor(Color.AppCardBackground)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(Color.AppText)
                    )
                    .onTapGesture {
                        recordCollectionViewModel.focusedIdentity = nil
                        showIdentitySelection = false
                    }
                IdentityGroupView(
                    displayMode: .Icon,
                    afterTap: {
                        showIdentitySelection = false
                    }
                )
            }
            .padding()
            .background(LinearGradient.ForIdentity)
            .presentationDetents([.medium])
        }
        // Organization Page
        .sheet(isPresented: $showOrganizationSelection) {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 40)
                    .foregroundColor(Color.AppCardBackground)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(Color.AppText)
                    )
                    .onTapGesture {
                        recordCollectionViewModel.focusedOrganization = nil
                        showOrganizationSelection = false
                    }
                OrganizationGroupView (
                    displayMode: .Icon,
                    afterTap: {
                        showOrganizationSelection = false
                    }
                )
            }
            .padding()
            .background(LinearGradient.ForOrganization)
            .presentationDetents([.medium])
        }
        .background(Color.AppCanvas)
        .onAppear {recordCollectionViewModel.clearFocus()}
        .onDisappear {recordCollectionViewModel.clearFocus()}
    }
}

struct CreateRecordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateRecordView()
                .environmentObject(RecordCollectionViewModel.SharedForPreview)
        }
    }
}
