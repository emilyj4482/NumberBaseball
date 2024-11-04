//
//  main.swift
//  NumberBaseball
//
//  Created by EMILY on 04/11/2024.
//

import Foundation

/**
 getAnswer 함수를 통해 제작한 정답을 담을 빈 값
 - Character type Array인 이유 : input 값의 각 자리수를 검사할 때 .map { $0 }을 이용할 건데, readLine()이 String type이고, 그것을 .map { $0 } 처리하면 [Character]이 되어 편리하기 때문
*/
var answer: [Character] = []

/**
 정답 제작 함수 : 1 ~ 9 사이의 서로 다른 임의의 수 3개를 뽑아 반환
 - `while` : 1 ~ 9 사이에서 뽑은 무작위 값에 대한 중복 검사를 한 뒤, `result`에 넣는다. 3개가 채워지면 종료
 */
func getAnswer() -> [Character] {
    let array = (1...9).map { Character("\($0)") }
    var result = [Character]()
    
    while result.count < 3 {
        if let digit = array.randomElement(),
           !result.contains(digit) {
            result.append(digit)
        }
    }
    // print(result)
    return result
}
/**
 게임 실행 함수
 1. `answer`에 `getAnswer()` 함수를 통해 뽑은 3개의 수를 담은 뒤
 2. `Game Start` 문구 출력
 3. 입력값을 받는 `getInput()` 함수 호출
 */
func startGame() {
    answer = getAnswer()
    print("[Game Start]")
    getInput()
}

/**
 게임 진행 함수 : 입력값을 받고, 값에 대한 검사를 진행
 1. 안내 문구 출력
 2. `input` 값에 대한 유효 검사를 `examInput` 함수를 통해 진행
 3. `getInput` 함수를 통해 정답 검사 진행 (게임 플레이)
 4. 정답 시 `Game End` 문구 출력 및 게임 종료
 */
func getInput() {
    print("Put a 3-digit number down below.")
    guard
        let input = readLine(),
        examInput(input)
    else {
        getInput()
        return
    }
    
    if input.map({ $0 }) == answer {
        print(">> correct!\n[Game End]")
    } else {
        examAnswer(input.map({ $0 }))
        getInput()
    }
}

/**
 입력값 유효 검사 함수
 - `input` : `readLine()`을 통해 받은 입력값 String
 - `guard`문을 통해 유효하지 않은 값이 입력될 때마다 에러 메시지를 출력하고 `false`를 return하며 exit
 - 입력값이 유효하여 모든 `guard`문을 통과할 경우 `true`를 return
 */
func examInput(_ input: String) -> Bool {
    guard !input.contains("0") else {
        print("[ERROR] The answer cannot contain zero.")
        return false
    }
    
    guard let input = Int(input) else {
        print("[ERROR] You should put an integer number only.")
        return false
    }
    
    guard input > 99 && input < 1000 else {
        print("[ERROR] You should put a 3-digit number only.")
        return false
    }
    
    guard Set(String(input).map({ $0 })).count == 3 else {
        print("[ERROR] You should put unique digits only.")
        return false
    }
    return true
}

/**
 정답 검사 및 힌트 제공 함수
 - `input` 값이 `[Character]`인 이유는 `String`인 `readLine()` 값에 대해 `.map { $0 }`한 값을 받기 때문이다.
 1) `anwser`과 `input` array를 동시에(`zip`) 순환하며(`forEach`) 자리와 값이 모두 일치하는 경우 `strike`의 count를 증가
 2) 교집합 메소드인 `intersection`을 사용하기 위해 `Set` 형변환을 하였으며 교집합 개수에서 `strike`를 빼준 값이 `ball`. (자리는 다르지만 같은 값이 존재하는 경우를 count)
 3) 검사 결과를 포함하는 hint 구문을 출력하는 `printHint` 함수를 호출
 */
func examAnswer(_ input: [Character]) {
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
}

/**
 힌트 출력 함수
 - `Int` 값인 `strike`, `ball`을 `parameter`로 받아 개수에 따른 메시지를 제작하여 출력
 - count가 0일 경우 0개라고 알려주는 것이 아니라 아예 출력하지 않도록 처리
 - 둘다 0일 경우 out 출력
 */
func printHint(_ strike: Int, _ ball: Int) {
    if strike > 0 && ball > 0 {
        print(">> \(strike) strike \(ball) ball")
    } else if strike > 0 {
        print(">> \(strike) strike")
    } else if ball > 0 {
        print(">> \(ball) ball")
    } else {
        print(">> out")
    }
}

// Game Play
startGame()
