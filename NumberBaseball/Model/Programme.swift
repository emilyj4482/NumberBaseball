//
//  Programme.swift
//  NumberBaseball
//
//  Created by EMILY on 05/11/2024.
//

import Foundation

class Programme {
    
    private let managers: ManagerType = Managers()
    
    /**
     프로그램 실행 함수
     1. 환영 문구 출력
     2. 사용자 입력값 chooseAction으로 전송
     */
    func start() {
        print(Messages.welcomeMessage)
        guard let input = readLine()
        else {
            print(Messages.unknownErrorMessage)
            return
        }
        chooseAction(input)
    }
    
    /**
     동작 분기 함수
     - 선택지에 따른 동작 [1] 게임 시작 [2] 기록 조회 [3] 프로그램 종료
     - 무효값 입력 시 에러 문구 출력 및 메인으로 회귀(다시 입력값 받음)
     */
    private func chooseAction(_ input: String) {
        switch input {
        case "1":
            startGame()
        case "2":
            getRecords()
        case "3":
            exit()
        default:
            print(Messages.invalidInputMessage)
            start()
        }
    }
    
    /**
     [1] 게임 시작 함수
     */
    private func startGame() {
        var game = Game(managers: managers)
        game.start()
        chooseAgain(afterGame: true)
    }
    
    /**
     [2] 기록 조회 함수
     */
    private func getRecords() {
        managers.recordManager.getRecords()
        chooseAgain(afterGame: false)
    }
    
    /**
     동작 분기 함수2
     - 게임 종료 후 또는 기록 조회 후 호출
     - 상태에 따라 질문지 다르게 출력, 동작 다르게 호출
     */
    private func chooseAgain(afterGame: Bool) {
        afterGame ? print(Messages.playAgainMessage) : print(Messages.goBackMessage)
        guard let input = readLine()
        else {
            print(Messages.unknownErrorMessage)
            return
        }
        switch input {
        case "1":
            afterGame ? startGame() : start()
        case "2":
            afterGame ? start() : exit()
        default:
            print(Messages.invalidInputMessage)
            chooseAgain(afterGame: afterGame)
        }
    }

    /**
     [3] 프로그램 종료 함수
     */
    private func exit() {
        print(Messages.farewellMessage)
    }
}
