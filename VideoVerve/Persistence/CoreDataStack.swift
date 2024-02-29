//
//  CoreDataStack.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 28/02/24.
//

import Foundation

import CoreData
import Combine

protocol PersistentStore {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
    
    func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error>
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>, map: @escaping (T) throws -> V?) -> AnyPublisher<LazyList<V>, Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
}

struct CoreDataStack: PersistentStore {
    
    private let container: NSPersistentContainer
    private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)
    private let bgQueue = DispatchQueue(label: "core-data")
    
    init() {
        
    }
    
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>, map: @escaping (T) throws -> V?) -> AnyPublisher<LazyList<V>, Error> where T : NSFetchRequestResult {
        
    }
    
    
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
        
    }
    
    func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error> where T : NSFetchRequestResult {
        
    }
    
    
}
