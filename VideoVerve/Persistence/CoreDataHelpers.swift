//
//  CoreDataHelpers.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import CoreData

protocol ManagedEntity: NSFetchRequestResult {}

extension ManagedEntity where Self: NSManagedObject {
    
    static var entityName: String {
        let nameManagedObject = String(describing: Self.self)
        let suffixIndex = nameManagedObject.index(nameManagedObject.endIndex, offsetBy: -2)
        return String(nameManagedObject[..<suffixIndex])
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? Self
    }
    
    
    static func newFetchRequest() -> NSFetchRequest<Self> {
        return .init(entityName: entityName)
    }
    
}


extension NSManagedObjectContext {
    
    func configureAsReadOnlyContext() {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSRollbackMergePolicy
        undoManager = nil
        shouldDeleteInaccessibleFaults = true
    }
    
    func configureAsUpdateContext() {
        mergePolicy = NSOverwriteMergePolicy
        undoManager = nil
    }
}
