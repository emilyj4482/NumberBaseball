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
}

class Managers: ManagerType {
    var checkManager: CheckManagerType
    var recordManager: RecordManagerType
    
    init() {
        self.checkManager = CheckManager()
        self.recordManager = RecordManager()
    }
}
