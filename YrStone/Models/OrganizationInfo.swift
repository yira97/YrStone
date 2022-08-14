//
//  OrganizationInfo.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/26.
//

import SwiftUI

struct OrganizationInfo: Equatable {
    var name: String
    var domains: [OrganizationDomainInfo] = []
    var managedEntity: YrOrganizationEntity?
}

extension OrganizationInfo {
    static func fromYrOrganizationEntity (entity: YrOrganizationEntity) -> OrganizationInfo {
        var domains = [OrganizationDomainInfo]()
        let domainEntities = entity.domainsArray()
        for domain in domainEntities {
            var domainInfo = OrganizationDomainInfo(value: domain.value!)
            domainInfo.managedEntity = domain
            domains.append(domainInfo)
        }
        
        var info = OrganizationInfo(name: entity.name!, domains: domains.displaySorting())
        info.managedEntity = entity
        return info
    }
}

extension OrganizationInfo {
    static private let halfSpace: Character = " "
    static private let fullSpace: Character = "　"
    
    // format references:
    // 1. "Yiran Feng" --> "Yiran"
    // 2. "Feng Yiran" --> "Feng"
    // 3. "佐藤　太郎" --> "佐藤"
    // 4. "yiran" --> "Yiran"
    var formattedName: String {
        get {
            var splitChar:Character?
            if (name.firstIndex(of: Self.halfSpace) != nil) {
                splitChar = Self.halfSpace
            } else if (name.firstIndex(of: Self.fullSpace) != nil) {
                splitChar = Self.fullSpace
            }
            
            var firstPart = name
            if let c = splitChar {
                let texts = name.split(separator: c)
                if (texts.count > 0) {
                    firstPart = String(texts.first!)
                }
            }
            
            return firstPart
        }
    }
    
    
    
    var nameBackgroundColor: Color {
        get {
            let (red, green, blue) = name.hashedRGB
            return Color(red: red/255, green: green/255, blue: blue/255)
        }
    }
}
