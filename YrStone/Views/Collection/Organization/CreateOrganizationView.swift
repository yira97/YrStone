//
//  CreateOrganizationView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct CreateOrganizationView: View {
    @State var inputOrganizationName: String = ""
    @State var inputOrganizationDomains: [String] = [""]
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create Organization")
                    .font(.title)
                    .bold()
                    .foregroundColor(.AppPrimary5)
                    .padding(.bottom)
                    .padding()
                RoundedIconTextField(value: $inputOrganizationName, icon: Image(systemName: "person.fill"), label: "Name")
                    .padding(.bottom)
                Text("Domains")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.AppPrimary5)
                    .padding()
                VStack {
                    VStack {
                        ForEach(Array(inputOrganizationDomains.enumerated()), id: \.offset) { index, element in
                            RoundedIconTextField(value: $inputOrganizationDomains[index], icon: Image(systemName: "list.bullet.rectangle.fill"), label: "Domain\(index+1)")
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color.AppBackgroundLight)
                    )
                    HStack {
                        Spacer()
                        Button("Add Field") {
                            guard (!inputOrganizationDomains.contains(where: {$0.isEmpty})) else {
                                return
                            }
                            inputOrganizationDomains.append("")
                        }
                        .buttonStyle(AddSthButton())
                        .padding()
                    }
                    
                    Button("Save") {
                        guard (inputOrganizationName.isNotEmpty) else {
                            return
                        }
                        var info = OrganizationInfo(name: inputOrganizationName)
                        info.domains = inputOrganizationDomains.filter({!$0.isEmpty}).map({ OrganizationDomainInfo(value:$0) })
                        recordCollectionViewModel.createOrganization(info: info)
                        dismiss()
                    }
                    .buttonStyle(PrimaryButton())
                }
                
            }
            .padding()
        }
    }
}
    
    struct CreateOrganizationView_Previews: PreviewProvider {
        static var previews: some View {
            CreateOrganizationView()
        }
    }
