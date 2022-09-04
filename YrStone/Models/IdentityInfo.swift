//
//  IdentityInfo.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import Foundation

struct IdentityInfo: Equatable {
    var name: String
    var avatarIndex: Int
    
    var managedEntity: YrIdentityEntity?
}

extension IdentityInfo {
    static func fromYrIdentityEntity(entity: YrIdentityEntity) -> IdentityInfo {
        var info = IdentityInfo(name: entity.name!, avatarIndex: Int(entity.avatarIndex))
        info.managedEntity = entity
        return info
    }
}
