//
//  RecordListView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/25.
//

import SwiftUI
import CoreData

struct RecordListView: View {
    @EnvironmentObject var recordCollectionViewModel: RecordCollectionViewModel
    
    
    var body: some View {
        ZStack {
            Color.AppCanvas
                .ignoresSafeArea(edges: [.top
                                        ])
            if (recordCollectionViewModel.records.isNotEmpty) {
                List {
                    ForEach(recordCollectionViewModel.records) { record in
                        NavigationLink(destination:
                                        RecordDetailView(record:RecordInfo.fromYrRecordEntity(entity: record))
                                       , label: {
                            RecordRowView(record: RecordInfo.fromYrRecordEntity(entity: record))
                        })
                    }
                    .onDelete { idxs in
                        var ids = Set<NSManagedObjectID>()
                        for idx in idxs {
                            ids.insert(recordCollectionViewModel.records[idx].objectID)
                        }
                        recordCollectionViewModel.deleteRecords(ids: ids)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("All Records")
    }
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
            .environmentObject(RecordCollectionViewModel.SharedForPreview)
    }
}
