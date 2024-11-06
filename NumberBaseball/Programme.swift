//
//  BaseballGame.swift
//  NumberBaseball
//
//  Created by EMILY on 05/11/2024.
//

import Foundation

class Programme {
    
    private var answer: [String] = []   // startGame()에서 제작된 정답이 할당될 빈 값
    private var count: Int = 0          // 단일 게임 guess 횟수가 저장될 빈 값
    private var counts: [Int] = []      // 게임 기록이 저장될 빈 값
    
    /**
     프로그램 실행 함수
     환영 문구를 출력하고, 다음 동작에 대한 사용자의 선택값을 받아 액션을 분기하는 함수에 전달한다.
     */
    func welcomeMessage() {
        print("Welcome to Number Baseball Game! Select a number.\n[1] Game Start [2] Records [3] Exit")
        guard let input = readLine()
        else {
            print("[ERROR] Unknown error occurred.")
            return
        }
        separateActions(input)
    }
    
    /**
     동작 분기 함수
     사용자가 입력한 값을 받고, 사용자 선택에 따라 다른 동작을 호출한다.
     유효하지 않은 값에 대해서는 에러 메시지를 출력하고 다시 `프로그램 실행 함수`로 회귀한다.
     */
    private func separateActions(_ input: String) {
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
    
    /**
     기록 조회 함수
     `counts`에 저장되어 있는 게임 별 count를 출력한다.
     출력이 완료되면 사용자에게 다음 동작을 묻는 함수를 호출한다.
     */
    private func getRecords() {
        print("[Your games so far]")
        if counts.count < 1 {
            print("0 games played. No records.")
        } else {
            counts.enumerated().forEach {
                print("GAME \($0.offset + 1) : \($0.element) \($0.element == 1 ? "guess" : "guesses")")
            }
        }
        askGoingBack()
    }
    
    /**
     동작 분기 함수
     */
    private func askGoingBack() {
        print("Want to go back to main menu?\n[1] Yes. [2] No, exit.")
        guard let input = readLine()
        else {
            print("[ERROR] Unknown error occurred.")
            return
        }
        switch input {
        case "1":
            welcomeMessage()
        case "2":
            Exit()
        default:
            print("[ERROR] Invalid input.")
            askGoingBack()
        }
    }

    /**
     프로그램 종료 함수
     */
    private func Exit() {
        print("Bye.")
    }
    
    /**
     게임 실행 함수
     1. `answer`에 정답 제작하여 할당
     2. `Game Start` 문구 출력
     3. 입력값을 받는 `getInput()` 함수 호출
     */
    private func startGame() {
        // create answer : 0 ~ 9를 담은 sequence의 순서를 shuffle 한 뒤 맨 앞 원소가 0이라면 제거하고 처음 3개의 원소를 추출하여 String으로 형변환한 배열
        answer = (0...9).shuffled().trimmingPrefix([0]).prefix(3).map { String($0) }
        print("[Game Start]")
        getInput()
    }

    /**
     게임 진행 함수
     사용자의 입력값을 받고, 값에 대한 검사를 진행한다.
     1. `input` 값에 대한 유효 검사를 `examInput` 함수를 통해 진행
     2. 유효성 검사를 통과한 값에 대해 `examAnswer` 함수를 통해 정답 검사 진행 (게임 플레이)
     4. 정답 시 게임이 종료되고 다음 동작에 대한 선택지를 받는 함수 호출
     */
    private func getInput() {
        print("Put a 3-digit number down below.")
        guard
            let input = readLine(),
            examInput(input)
        else {
            getInput()
            return
        }
        
        let inputToArray = input.map { String($0) }
        
        // 유효한 입력값인 경우, count + 1
        count += 1
        
        if inputToArray == answer {
            print(">> correct!\n[Game End]")
            // 정답을 맞혀 게임 종료 시 count를 배열에 저장하고 count 값을 비움
            counts.append(count)
            count = 0
            askPlayingAgain()
        } else {
            examAnswer(inputToArray)
            getInput()
        }
    }
    
    /**
     동작 분기 함수
     */
    private func askPlayingAgain() {
        print("Play Again?\n[1] Yes. [2] No, go to main. [3] No, exit.")
        guard let input = readLine()
        else {
            print("[ERROR] Unknown error occurred.")
            return
        }
        switch input {
        case "1":
            startGame()
        case "2":
            welcomeMessage()
        case "3":
            Exit()
        default:
            print("[ERROR] Invalid input.")
            askPlayingAgain()
        }
    }

    /**
     입력값 유효 검사 함수
     - `guard`문을 통해 유효하지 않은 값이 입력될 때마다 에러 메시지를 출력하고 `false`를 return하며 exit
     - 입력값이 유효하여 모든 `guard`문을 통과할 경우 `true`를 return
     */
    private func examInput(_ input: String) -> Bool {
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
     1) `anwser`과 `input` array를 동시에(`zip`) 순환하며(`forEach`) 자리와 값이 모두 일치하는 경우 `strike`의 count를 증가
     2) 교집합 메소드인 `intersection`을 사용하기 위해 `Set` 형변환을 하였으며 교집합 개수에서 `strike`를 빼준 값이 `ball`
     3) 결과에 따라 힌트를 출력하는 `printHint` 함수 호출
     */
    private func examAnswer(_ input: [String]) {
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
     - `strike`와 `ball` 개수에 따른 메시지를 제작하여 출력
     - count가 0일 경우 0개라고 알려주는 것이 아니라 아예 출력하지 않도록 처리
     - 둘다 0일 경우 out 출력
     */
    private func printHint(_ strike: Int, _ ball: Int) {
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
}
