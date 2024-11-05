//
//  main.swift
//  NumberBaseball
//
//  Created by EMILY on 04/11/2024.
//

import Foundation

func welcomeMessage() {
    print("Welcome to Number Baseball Game! Select a number.\n[1] Game Start [2] Records [3] Exit")
    guard let input = readLine()
    else {
        print("[ERROR] Unknown error occurred.")
        return
    }
    separateActions(input)
}

func separateActions(_ input: String) {
    switch input {
    case "1":
        startGame()
    case "2":
        getRecords()
    case "3":
        Exit()
    default:
        print("[ERROR] You should put among 1, 2 and 3 only.")
        welcomeMessage()
    }
}

func getRecords() {
    print("[2] selected")
    // TODO: 기록 보기 구현
    
    // 기록 출력 후 다시 초기 선택 시점으로 돌아감
    welcomeMessage()
}

// 프로그램 완전 종료 지점
func Exit() {
    print("Bye.")
}

/**
 startGame() 함수가 실행되면 정답을 제작하여 담을 빈 값
 - String type Array인 이유 : input 값의 각 자리수를 검사할 때 .map을 이용할 건데, readLine()이 String type이고, 그것을 .map { Int($0 } 처리하면 optional이지만 .map { String($0) }으로 하면 확정적으로 변환되기 때문
*/
var answer = [String]()

/**
 게임 실행 함수
 1. `answer`에 `getAnswer()` 함수를 통해 뽑은 3개의 수를 담은 뒤
 2. `Game Start` 문구 출력
 3. 입력값을 받는 `getInput()` 함수 호출
 */
func startGame() {
    // create answer : 0 ~ 9를 담은 sequence의 순서를 shuffle 한 뒤 맨 앞 원소가 0이라면 제거하고 처음 3개의 원소를 추출하여 String으로 형변환한 배열
    answer = (0...9).shuffled().trimmingPrefix([0]).prefix(3).map { String($0) }
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
    
    let inputToArray = input.map { String($0) }
    
    if inputToArray == answer {
        print(">> correct!\n[Game End]")
        // 게임 종료 후 다시 초기 선택 시점으로 돌아감
        welcomeMessage()
    } else {
        examAnswer(inputToArray)
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
    guard Set(Array(input)).count == 3 else {
        print("[ERROR] You should put unique digits only.")
        return false
    }
    
    guard !input.hasPrefix("0") else {
        print("[ERROR] The answer cannot start with zero.")
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
    
    return true
}

/**
 정답 검사 및 힌트 제공 함수
 - `input` 값이 `[Character]`인 이유는 `String`인 `readLine()` 값에 대해 `.map { $0 }`한 값을 받기 때문이다.
 1) `anwser`과 `input` array를 동시에(`zip`) 순환하며(`forEach`) 자리와 값이 모두 일치하는 경우 `strike`의 count를 증가
 2) 교집합 메소드인 `intersection`을 사용하기 위해 `Set` 형변환을 하였으며 교집합 개수에서 `strike`를 빼준 값이 `ball`. (자리는 다르지만 같은 값이 존재하는 경우를 count)
 3) 검사 결과를 포함하는 hint 구문을 출력하는 `printHint` 함수를 호출
 */
func examAnswer(_ input: [String]) {
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
// startGame()
// Programme Open
welcomeMessage()
