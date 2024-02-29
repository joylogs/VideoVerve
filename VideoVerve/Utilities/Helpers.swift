//
//  Helpers.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation






extension Result {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
}
