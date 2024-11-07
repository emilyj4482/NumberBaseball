//
//  InputManager.swift
//  NumberBaseball
//
//  Created by EMILY on 08/11/2024.
//

import Foundation

protocol InputManagerType {
    func readInput() throws -> String
}

class InputManager: InputManagerType {
    func readInput() throws -> String {
        guard let input = readLine() else {
            throw InputError.unknown
        }
        return input
    }
}
