//
//  RecordCollectionStore.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/08.
//

import Foundation
import CoreData

struct RecordCollectionStore {
    
    var selectedOrganization: YrOrganizationEntity? {
        didSet {
            loadRecords()
        }
    }
    
    var selectedIdentity: YrIdentityEntity? {
        didSet {
            loadRecords()
        }
    }
    
    private var _context: NSManagedObjectContext
    
    private(set) var records: [YrRecordEntity] = []
    
    private(set) var organizations: [YrOrganizationEntity] = []
    
    private(set) var identities: [YrIdentityEntity] = []
    
    private func getRecords () -> [YrRecordEntity] {
        let request: NSFetchRequest<YrRecordEntity> = YrRecordEntity.fetchRequest()
        
        var fetchPredicates: [NSPredicate] = []
        if let selection = selectedIdentity {
            fetchPredicates.append(NSPredicate(format: "%K = %@", #keyPath(YrRecordEntity.identity), selection))
        }
        if let selection = selectedOrganization {
            fetchPredicates.append(NSPredicate(format: "%K = %@", #keyPath(YrRecordEntity.organization), selection))
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: fetchPredicates)
        
        do {
            return try _context.fetch(request)
        }
        catch {
            fatalError("Error getting data: \(error.localizedDescription)")
        }
    }
    
    private func getOrganization (name: String) -> YrOrganizationEntity? {
        let request: NSFetchRequest<YrOrganizationEntity> = YrOrganizationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(YrOrganizationEntity.name), name)
        do {
            let fetchResult =  try _context.fetch(request)
            return fetchResult.first
        }
        catch {
            fatalError("Error getting data: \(error.localizedDescription)")
        }
    }
    
    private func getOrganizations () -> [YrOrganizationEntity] {
        let request: NSFetchRequest<YrOrganizationEntity> = YrOrganizationEntity.fetchRequest()
        
        do {
            return try _context.fetch(request)
        }
        catch {
            fatalError("Error getting data: \(error.localizedDescription)")
        }
    }
    
    private func getIdentity (name: String) -> YrIdentityEntity? {
        let request: NSFetchRequest<YrIdentityEntity> = YrIdentityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(YrIdentityEntity.name), name)
        do {
            let fetchResult =  try _context.fetch(request)
            return fetchResult.first
        }
        catch {
            fatalError("Error getting data: \(error.localizedDescription)")
        }
    }
    
    private func getIdentities () -> [YrIdentityEntity] {
        let request: NSFetchRequest<YrIdentityEntity> = YrIdentityEntity.fetchRequest()
        
        do {
            return try _context.fetch(request)
        }
        catch {
            fatalError("Error getting data: \(error.localizedDescription)")
        }
    }
    
    mutating func loadIdentities() {
        identities = getIdentities()
    }
    
    mutating func loadOrganizations() {
        organizations = getOrganizations()
    }
    
    mutating func loadCategories() {
        loadIdentities()
        loadOrganizations()
    }
    
    mutating func loadRecords() {
        records = getRecords()
        dump(records.map({RecordInfo.fromYrRecordEntity(entity: $0)}))
    }
    
    init (context: NSManagedObjectContext) {
        _context = context
        
        loadCategories()
        loadRecords()
    }
    
    private func save() -> Bool {
        if (!_context.hasChanges) {return false}
        do {
            try self._context.save()
            return true
        }
        catch {
            fatalError("Error saving data: \(error.localizedDescription)")
        }
    }
    
    mutating func createRecord (info: RecordInfo, organizationName: String?, identityName: String?) {
        if (info.username.isEmpty || info.password.isEmpty) {return}
        let record = YrRecordEntity(context: _context)
        record.username = info.username
        record.password = info.password
        for extra in info.extraContents {
            let field = YrRecordFieldEntity(context: _context)
            field.desc = extra.desc
            field.content = extra.content
            field.record = record
        }
        
        if let name = identityName, name.isNotEmpty {
            if let identity = getIdentity(name: name) {
                record.identity = identity
            }
        }
        
        if let name = organizationName, name.isNotEmpty {
            if let organization = getOrganization(name: name) {
                record.organization = organization
            }
        }
        
        if (save()) {
            loadRecords()
        }
    }
    
    private func constructOrganizationDomain(infos: [OrganizationDomainInfo], organization: YrOrganizationEntity) {
        for info in infos {
            let domainEntity = YrOrganizationDomainEntity(context: _context)
            domainEntity.value = info.value
            domainEntity.organization = organization
        }
    }
    
    private func constructRecordField(infos: [RecordInfo.ExtraContent], record: YrRecordEntity) {
        for info in infos {
            let fieldEntity = YrRecordFieldEntity(context: _context)
            fieldEntity.desc = info.desc
            fieldEntity.content = info.content
            fieldEntity.record = record
        }
    }
    
    mutating func createOrganization (info: OrganizationInfo) {
        let organization = YrOrganizationEntity(context: _context)
        organization.name = info.name
        if (info.domains.isNotEmpty) {
            constructOrganizationDomain(infos: info.domains, organization: organization)
        }
        
        if (save()) {
            loadCategories()
        }
    }
    
    mutating func createIdentity (info: IdentityInfo) {
        let identityEntity = YrIdentityEntity(context: _context)
        identityEntity.name = info.name
        
        if(save()) {
            loadIdentities()
        }
    }
    
    mutating func deleteRecords (ids: Set<NSManagedObjectID>) {
        for id in ids {
            let object = _context.object(with: id)
            _context.delete(object)
        }
        if(save()) {
            loadRecords()
        }
    }
    
    mutating func deleteIdentities (ids: Set<NSManagedObjectID>) {
        for id in ids {
            let object = _context.object(with: id)
            _context.delete(object)
        }
        if(save()) {
            loadIdentities()
        }
    }
    
    mutating func deleteOrganizations (ids: Set<NSManagedObjectID>) {
        for id in ids {
            let object = _context.object(with: id)
            _context.delete(object)
        }
        if (save()) {
            loadOrganizations()
        }
    }
    
    mutating func updateIdentity(info: IdentityInfo) {
        guard let entity = info.managedEntity else {
            return
        }
        if (entity.name != info.name) {
            entity.name = info.name
        }
        if(save()) {
            loadRecords()
        }
    }
    
    mutating func updateOrganization(info organizationInfo: OrganizationInfo) {
        guard let organizationEntity = organizationInfo.managedEntity else {
            return
        }
        // handle name
        if (organizationEntity.name != organizationInfo.name) {
            organizationEntity.name = organizationInfo.name
        }
        
        let domainEntities = organizationEntity.domainsArray().displaySorting()
        let domainInfos = organizationInfo.domains.displaySorting()
            
        for i in 0..<max(domainEntities.count, domainInfos.count) {
            if (domainInfos.count > i && domainEntities.count > i) {
                if (domainEntities[i].value != domainInfos[i].value) {
                    domainEntities[i].value = domainInfos[i].value
                }
                continue
            }
            if (domainInfos.count > i) {
                constructOrganizationDomain(infos: [domainInfos[i]], organization: organizationEntity)
            } else {
                _context.delete(domainEntities[i])
            }
        }
        
        if (save()) {
            loadOrganizations()
        }
    }
    
    mutating func updateRecord(info recordInfo: RecordInfo) {
        guard let recordEntity = recordInfo.managedEntity else {
            return
        }
        if (recordEntity.username != recordInfo.username) {
            recordEntity.username = recordInfo.username
        }
        if (recordEntity.password != recordInfo.password) {
            recordEntity.password = recordInfo.password
        }
        
        let fieldEntities = recordEntity.fieldArray().displaySorting()
        let fieldInfos = recordInfo.extraContents.filter({$0.content.isNotEmpty && $0.desc.isNotEmpty}).displaySorting()
        
        for i in 0..<max(fieldEntities.count, fieldInfos.count) {
            if (fieldEntities.count > i && fieldInfos.count > i) {
                if (fieldEntities[i].desc != fieldInfos[i].desc) {
                    fieldEntities[i].desc = fieldInfos[i].desc
                }
                if (fieldEntities[i].content != fieldInfos[i].content) {
                    fieldEntities[i].content = fieldInfos[i].content
                }
                continue
            }
            if (fieldInfos.count > i) {
                constructRecordField(infos: [fieldInfos[i]], record: recordEntity)
            } else {
                _context.delete(fieldEntities[i])
            }
        }
        
        if (save()) {
            loadRecords()
        }
    }
}
