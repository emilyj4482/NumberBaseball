//
//  ManagerType.swift
//  NumberBaseball
//
//  Created by EMILY on 08/11/2024.
//

import Foundation

protocol ManagerType {
    var checkManager: CheckManagerType { get }
    var recordManager: RecordManagerType { get }
    var inputManager: InputManagerType { get }
}

class Managers: ManagerType {
    var checkManager: CheckManagerType
    var recordManager: RecordManagerType
    var inputManager: InputManagerType
    
    init() {
        self.checkManager = CheckManager()
        self.recordManager = RecordManager()
        self.inputManager = InputManager()
    }
}
