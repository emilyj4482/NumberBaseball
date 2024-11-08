//
//  Game.swift
//  NumberBaseball
//
//  Created by EMILY on 06/11/2024.
//

import Foundation

struct Game {
    private var answer: [String]
    private var count: Int
    
    private let managers: ManagerType
    
    init(answer: [String] = [], count: Int = 0, managers: ManagerType) {
        self.answer = answer
        self.count = count
        self.managers = managers
    }
    
    /**
     정답 제작 함수
     */
    private func createAnswer() -> [String] {
        return (0...9).shuffled().trimmingPrefix([0]).prefix(3).map { String($0) }
    }
    
    /**
     시도 횟수 증가 함수
     - 입력값 유효 검사 통과 시 카운트 증가
     */
    private mutating func countUp() {
        self.count += 1
    }
    
    /**
     게임 실행 함수
     1. answer에 정답 제작하여 할당
     2. Game Start 문구 출력
     3. 게임 플레이 함수 호출
     */
    mutating func start() {
        answer = createAnswer()
        print(Messages.gameStartMessage)
        play()
    }

    /**
     게임 플레이 함수
     1. 사용자 입력
     2. check manager를 통해 유효성 검사
     - 실패 시 다시 입력값을 받도록 play 회귀
     - 성공 시 check manager를 통해 정답 검사
     3. 정답일 경우 end 함수 호출
     - 오답일 경우 다시 입력값을 받도록 play 회귀
     */
    private mutating func play() {
        print(Messages.gettingInputMessage)
        let input = readLine() ?? ""
        let checkManager = managers.checkManager
        let result = checkManager.checkInput(input)
        
        switch result {
        case .success(let array):
            countUp()
            if checkManager.checkAnswer(input: array, answer: answer) {
                end()
            } else {
                play()
            }
        case .failure(let error):
            print(error.localizedDescription)
            play()
        }
    }
    
    /**
     게임 종료 함수
     종료 메시지와 함께 게임 결과를 record manager에 저장한다.
     */
    private mutating func end() {
        print(Messages.gameEndMessage)
        managers.recordManager.addRecord(count)
    }

}
