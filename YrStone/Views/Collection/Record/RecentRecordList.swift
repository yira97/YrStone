//
//  RecentRecordList.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/23.
//

import SwiftUI

struct RecentRecordList: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    var maxNumber = 5
    
    var body: some View {
        let count = min(recordCollectionViewModel.records.count, maxNumber)
        
        VStack {
            HStack {
                Text("Recent Records")
                    .bold()
                    .foregroundColor(Color.AppTextDark)
                Spacer()
                
                
                NavigationLink {
                    RecordListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.AppPrimary2)
                }
            }
            .padding(.top)
            
            if (count == 0) {
                NoRecordPlaceholder()
                .padding(.top)
            }
            
            ForEach(Array(recordCollectionViewModel.records.prefix(count).enumerated()), id: \.element) { index, record in
                let info = RecordInfo.fromYrRecordEntity(entity: record)
                NavigationLink(destination: RecordDetailView(record: info), label: {
                    RecordRowView(record: info)
                })
                
                if (index != count - 1) { Divider() }
            }
        }
        .padding(.horizontal)
        .background(Color.AppSecondaryLight)
        .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
    }
}

struct RecentRecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecentRecordList()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
