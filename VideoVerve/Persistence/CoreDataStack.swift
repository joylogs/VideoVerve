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
    
    
    func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error>
    func fetch(_ fetchRequest: NSFetchRequest) -> AnyPublisher<>
}
