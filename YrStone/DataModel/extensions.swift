//
//  extensions.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/30.
//

import Foundation

extension YrOrganizationEntity {
    func domainsArray() -> [YrOrganizationDomainEntity] {
        self.domains?.toArray() ?? []
    }
}

extension Array<YrOrganizationDomainEntity> {
    func displaySorting() -> [YrOrganizationDomainEntity] {
        self.sorted(using: [
            KeyPathComparator(\.value, order: .forward)
        ])
    }
}

extension YrRecordEntity {
    func fieldArray() -> [YrRecordFieldEntity] {
        self.fields?.toArray() ?? []
    }
}

extension Array<YrRecordFieldEntity> {
    func displaySorting() -> [YrRecordFieldEntity] {
        self.sorted(using: [
            KeyPathComparator(\.desc, order: .forward),
            KeyPathComparator(\.content, order: .forward),
        ])
    }
}
