//
//  CheckManager.swift
//  NumberBaseball
//
//  Created by EMILY on 07/11/2024.
//

import Foundation

protocol CheckManagerType {
    func checkInput(_ input: String) -> Result<[String], InputError>
    func checkAnswer(input: [String], answer: [String]) -> Bool
}

class CheckManager: CheckManagerType {
    /**
     입력값 유효 검사 함수
     */
    func checkInput(_ input: String) -> Result<[String], InputError> {
        guard !input.hasPrefix("0") else {
            return .failure(.prefixZero)
        }
        
        guard let integer = Int(input) else {
            return .failure(.notInteger)
        }
        
        guard integer > 99 && integer < 1000 else {
            return .failure(.digitsOutOfRange)
        }
        
        guard Set(Array(integer.description)).count == 3 else {
            return .failure(.overlapNumber)
        }
        
        let inputToArray = input.description.map { String($0) }
        return .success(inputToArray)
    }
    
    /**
     정답 검사 및 힌트 제공 함수
     - strike와 ball을 검사하여 힌트 출력 함수 printHint로 전달
     - 정답일 시 true 오답일 시 false 반환
     */
    func checkAnswer(input: [String], answer: [String]) -> Bool {
        var strike: Int = 0
        var ball: Int = 0
        
        // 1) count strike
        zip(answer, input).forEach {
            if $0 == $1 {
                strike += 1
            }
        }
        
        // 2) count ball
        ball = Set(answer).intersection(input).count - strike
        
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
        if strike == 3 {
            print(">>> correct!")
        } else if strike > 0 && ball > 0 {
            print(">>> \(strike) strike \(ball) ball")
        } else if strike > 0 {
            print(">>> \(strike) strike")
        } else if ball > 0 {
            print(">>> \(ball) ball")
        } else {
            print(">>> out")
        }
    }
}
