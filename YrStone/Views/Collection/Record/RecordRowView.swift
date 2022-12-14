//
//  RecordRowView.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/22.
//

import SwiftUI
import CoreData

struct RecordRowView: View {
    var record: RecordInfo
    
    var body: some View {
        let organizationName = record.organization?.formattedName ?? "Indivisual"
        
        HStack(spacing: 20) {
            AvatarBase(index: record.identity?.avatarIndex,width: 40)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(organizationName)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                Text(record.username)
                    .font(.footnote)
                    .opacity(0.8)
                    .lineLimit(1)
                HStack {
                    if (record.extraContents.isEmpty) {
                        Text("")
                    } else {
                        ForEach(record.extraContents.prefix(2)) { extra in
                            Text(extra.desc)
                                .font(.footnote)
                                .opacity(0.5)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .foregroundColor(Color.AppText)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct RecordRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecordRowView(record: RecordInfo.Random())
    }
}
