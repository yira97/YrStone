//
//  OrganizationDomainInfo.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/30.
//

import Foundation

struct OrganizationDomainInfo: Equatable, Hashable {
    var value: String
    var managedEntity: YrOrganizationDomainEntity?
}

extension Array<OrganizationDomainInfo> {
    func displaySorting() -> [OrganizationDomainInfo] {
        self.sorted(using: [
            KeyPathComparator(\.value, order: .forward),
        ])
    }
}
