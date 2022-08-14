//
//  OrganizationDetailView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct OrganizationDetailView: View {
    @EnvironmentObject var vm: RecordCollectionViewModel
    @State var inputName: String = ""
    @State var inputDomains: [OrganizationDomainInfo] = []
    @State var editMode = false
    
    func getChanged(info: OrganizationInfo) -> Bool {
        inputName != info.name || inputDomains != info.domains
    }
    
    var body: some View {
        if (vm.focusedOrganization == nil) {
            Text("something wrong")
        } else {
            let info = OrganizationInfo.fromYrOrganizationEntity(entity: vm.focusedOrganization!)
            ZStack(alignment: .topTrailing) {
                VStack {
                    Text("Detail")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.AppPrimary5)
                        .padding()
                    Divider()
                    RoundedIconTextField(value: $inputName, icon: Image.OrganizationIcon, label: "Name", editable: editMode, color: info.name == inputName ? .AppPrimary5 : .AppPrimary2)
                        .padding()
                    Text("Domains")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.AppPrimary5)
                    ScrollView {
                        VStack {
                            ForEach(Array(inputDomains.enumerated()), id: \.offset) { index, element in
                                RoundedIconTextField(
                                    value: $inputDomains[index].value,
                                    icon: Image(systemName: "list.bullet.rectangle.fill"),
                                    label: "Domain\(index+1)", editable: editMode,
                                    height: 40,
                                    color:index<info.domains.count && info.domains[index].value == inputDomains[index].value ? Color.AppPrimary5 : .AppPrimary2
                                )
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(Color.AppBackgroundLight)
                        )
                    }
                    HStack {
                        Spacer()
                        if (editMode) {
                            Button("Add Field") {
                                guard (!inputDomains.contains(where: {$0.value.isEmpty})) else {
                                    return
                                }
                                inputDomains.append(.init(value: ""))
                            }
                            .buttonStyle(AddSthButton())
                            .padding()
                        }
                    }
                }
                
                Button(action: {
                    inputDomains = inputDomains.filter({$0.value.isNotEmpty})
                    if (editMode && getChanged(info: info)) {
                        var updateInfo = info
                        updateInfo.name = inputName
                        updateInfo.domains = inputDomains
                        vm.updateOrganization(info: updateInfo)
                    }
                        editMode = !editMode
                        }) {
                        Image(systemName: editMode ? "checkmark" : "pencil")
                    }
                        .buttonStyle(ToolBarButton(revColor: editMode))
                        .padding()
                }
                    .onAppear{
                        inputName = info.name
                        inputDomains = info.domains
                    }
                       }
                       }
                       }
                       
                       struct OrganizationDetailView_Previews: PreviewProvider {
                    static var previews: some View {
                        OrganizationDetailView()
                            .environmentObject(RecordCollectionViewModel.SharedForPreview)
                    }
                }
