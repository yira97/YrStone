//
//  RecordInfo.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import Foundation
import CoreData

struct RecordInfo: Equatable {
    struct ExtraContent: Equatable {
        var content: String
        var desc: String
    }
    
    var id: NSManagedObjectID = NSManagedObjectID()
    var username: String
    var password: String
    
    var extraContents: [ExtraContent] = []
    
    var organization: OrganizationInfo?
    var identity: IdentityInfo?
    
    var managedEntity: YrRecordEntity?
}

extension RecordInfo.ExtraContent: Identifiable {
    var id: String {
        return desc
    }
}

extension RecordInfo.ExtraContent {
    static func fromYrRecordFieldEntity(entity: YrRecordFieldEntity) -> RecordInfo.ExtraContent {
        let extra = RecordInfo.ExtraContent(content: entity.content!, desc: entity.desc!)
        return extra
    }
}

extension RecordInfo.ExtraContent {
    func isValid () -> Bool {
        self.content.isNotEmpty &&
        self.desc.isNotEmpty
    }
}

extension Array<RecordInfo.ExtraContent> {
    func displaySorting() -> [RecordInfo.ExtraContent] {
        self.sorted(using: [
            KeyPathComparator(\.desc, order: .forward),
            KeyPathComparator(\.content, order: .forward),
        ])
    }
    
    func valid() -> Bool {
        self.allSatisfy { $0.isValid() }
    }
}

extension RecordInfo {
    static func fromYrRecordEntity(entity: YrRecordEntity) -> RecordInfo {
        var info = RecordInfo(id: entity.objectID, username: entity.username!, password: entity.password!)
        
        if let fields:[YrRecordFieldEntity] = entity.fields?.toArray() {
            for field in fields {
                info.extraContents.append(RecordInfo.ExtraContent.fromYrRecordFieldEntity(entity: field))
            }
        }
        
        if let organization = entity.organization {
            info.organization = OrganizationInfo.fromYrOrganizationEntity(entity: organization)
        }
        
        if let identity = entity.identity {
            info.identity = IdentityInfo.fromYrIdentityEntity(entity: identity)
        }
        
        info.managedEntity = entity
        
        return info
    }
}

extension RecordInfo {
    static func Random() -> RecordInfo {
        var info = RecordInfo(username: "fangyira@gmail.com", password: "123456")
        info.extraContents = [RecordInfo.ExtraContent(content: "123-4567-890", desc: "phone"), RecordInfo.ExtraContent(content: "123-4567", desc: "post code")]
        info.organization = OrganizationInfo(name: "Apple",domains: [.init(value: "apple.com"),.init(value: "icloud.com")])
        info.identity = IdentityInfo(name: "Yiran Feng", avatarIndex: 3)
        return info
    }
}

extension RecordInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
