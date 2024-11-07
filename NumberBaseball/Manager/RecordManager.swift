//
//  RecordManager.swift
//  NumberBaseball
//
//  Created by EMILY on 07/11/2024.
//

import Foundation

protocol RecordManagerType {
    func getRecords()
    func addRecord(_ record: Int)
}

class RecordManager: RecordManagerType {
    private var records: [Int] = []
    
    /**
     기록 조회 함수
     - 프로그램 메인에서 호출
     */
    func getRecords() {
        print(Messages.gettingRecordsMessage)
        if records.isEmpty {
            print(Messages.noRecordMessage)
        } else {
            records.enumerated().forEach {
                print("GAME \($0.offset + 1) >>> \($0.element) \($0.element == 1 ? "guess" : "guesses")")
            }
        }
    }
    
    /**
     기록 추가 함수
     - 게임 종료 시 호출
     */
    func addRecord(_ record: Int) {
        records.append(record)
    }
}
