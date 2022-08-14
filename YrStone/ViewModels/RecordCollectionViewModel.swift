//
//  RecordCollectionViewModel.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/08.
//

import SwiftUI
import CoreData

class RecordCollectionViewModel : ObservableObject {
    
    @Published var focusedIdentity: YrIdentityEntity?
    @Published var focusedOrganization: YrOrganizationEntity?
    
    @Published private var  _recordCollectionStore : RecordCollectionStore
    
    init (recordCollectionStore: RecordCollectionStore) {
        _recordCollectionStore = recordCollectionStore
    }
    
    var selectedOrganization: YrOrganizationEntity? {
        get {
            self._recordCollectionStore.selectedOrganization
        }
        set {
            self._recordCollectionStore.selectedOrganization = newValue
        }
    }
    
    var selectedIdentity: YrIdentityEntity? {
        get {
            self._recordCollectionStore.selectedIdentity
        }
        set {
            self._recordCollectionStore.selectedIdentity = newValue
        }
    }
    
    var records: [YrRecordEntity] {
        get {
            self._recordCollectionStore.records
        }
    }
    
    var organizations: [YrOrganizationEntity] {
        get {
            self._recordCollectionStore.organizations
        }
    }
    
    var identities: [YrIdentityEntity] {
        get {
            self._recordCollectionStore.identities
        }
    }
    
    func createRecord(info: RecordInfo, identityName: String?, organizationName: String?) {
        _recordCollectionStore.createRecord(info: info, organizationName: organizationName, identityName: identityName)
    }
    
    func createOrganization(info: OrganizationInfo) {
        _recordCollectionStore.createOrganization(info: info)
    }
    
    func createIdentity(info: IdentityInfo) {
        _recordCollectionStore.createIdentity(info: info)
    }
    
    static func NewInstance() -> RecordCollectionViewModel {
        let recordCollectionStore = RecordCollectionStore(context: PersistenceController.shared.container.viewContext)
        let recordCollectionViewModel = RecordCollectionViewModel(recordCollectionStore: recordCollectionStore)
        return recordCollectionViewModel
    }
    
    static var SharedForPreview: RecordCollectionViewModel {
        let recordCollectionStore = RecordCollectionStore(context: PersistenceController.preview.container.viewContext)
        let recordCollectionViewModel = RecordCollectionViewModel(recordCollectionStore: recordCollectionStore)
        return recordCollectionViewModel
    }
    
    func deleteRecords (ids: Set<NSManagedObjectID>) {
        _recordCollectionStore.deleteRecords(ids: ids)
    }
    
    func deleteIdentities (ids: Set<NSManagedObjectID>) {
        _recordCollectionStore.deleteIdentities(ids: ids)
    }
    
    func deleteOrganizations (ids: Set<NSManagedObjectID>) {
        _recordCollectionStore.deleteOrganizations(ids: ids)
    }
    
    func updateIdentity(info: IdentityInfo) {
        _recordCollectionStore.updateIdentity(info: info)
    }
    
    func updateOrganization(info: OrganizationInfo) {
        _recordCollectionStore.updateOrganization(info: info)
    }
    
    func updateRecord(info: RecordInfo) {
        _recordCollectionStore.updateRecord(info: info)
    }
}
