//
//  FeedModelData.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import Foundation

class FeedsModel: ObservableObject {
//    @Published var data: FeedData = load("feedData.json")
}


func load<T: Decodable>(_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Could not find \(filename) in the Main Bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch(let error) {
        fatalError("Could not load file \(filename) from Main Bundle with: \(error)")
    }
    
    do {
        let decoder = try JSONDecoder().decode(T.self, from: data)
        return decoder
    } catch {
        fatalError("Failed to parse \(filename) as \(T.self) with: \(error)")
    }
}
