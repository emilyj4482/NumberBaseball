//
//  CheckManager.swift
//  NumberBaseball
//
//  Created by EMILY on 07/11/2024.
//

import Foundation

protocol CheckManagerType {
    func checkInput(_ input: String) -> Result<[Int], InputError>
    func checkAnswer(input: [Int], answer: [Int]) -> Bool
}

class CheckManager: CheckManagerType {
    /**
     입력값 유효 검사 함수
     */
    func checkInput(_ input: String) -> Result<[Int], InputError> {
        guard !input.hasPrefix("0") else {
            return .failure(.prefixZero)
        }
        
        guard let integer = Int(input) else {
            return .failure(.notInteger)
        }
        
        guard 100...999 ~= integer else {
            return .failure(.digitsOutOfRange)
        }
        
        guard Set(Array(integer.description)).count == 3 else {
            return .failure(.overlapNumber)
        }
        
        let inputToArray = input.compactMap { $0.wholeNumberValue }
        return .success(inputToArray)
    }
    
    /**
     정답 검사 및 힌트 제공 함수
     - strike와 ball을 검사하여 힌트 출력 함수 printHint로 전달
     - 정답일 시 true 오답일 시 false 반환
     */
    func checkAnswer(input: [Int], answer: [Int]) -> Bool {
        var strike: Int = 0
        var ball: Int = 0
        
        for (index, element) in answer.enumerated() {
            if input[index] == element {
                strike += 1
            } else if input.contains(element) {
                ball += 1
            }
        }
        
        printHint(strike, ball)
        
        if strike == 3 {
            return true
        } else {
            return false
        }
    }
    
    /**
     힌트 출력 함수
     - count가 0일 경우 0개라고 알려주는 것이 아니라 아예 출력하지 않도록 처리
     */
    private func printHint(_ strike: Int, _ ball: Int) {
        switch (strike, ball) {
        case (0, 0): print(">>> out")
        case (3, 0): print(">>> correct!")
        case (_, 0): print(">>> \(strike) strike")
        case (0, _): print(">>> \(ball) ball")
        case (_, _): print(">>> \(strike) strike, \(ball) ball")
        }
    }
}
