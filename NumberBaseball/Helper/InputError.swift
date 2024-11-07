//
//  InputError.swift
//  NumberBaseball
//
//  Created by EMILY on 07/11/2024.
//

import Foundation

enum InputError: Error {
    case overlapNumber
    case prefixZero
    case notInteger
    case digitsOutOfRange
    case invalidInput
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .overlapNumber: "[ERROR] You should put unique digits only."
        case .prefixZero: "[ERROR] The answer cannot start with zero."
        case .notInteger: "[ERROR] You should put an integer number only."
        case .digitsOutOfRange: "[ERROR] You should put a 3-digit number only."
        case .invalidInput: "[ERROR] Invalid input."
        case .unknown: "[ERROR] Unknown error occurred."
        }
    }
}
