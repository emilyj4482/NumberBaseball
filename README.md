# Swift로 야구게임 만들기
> 숫자 야구 게임은 두 명이 즐길 수 있는 추리 게임으로, 상대방이 설정한 3자리의 숫자를 맞히는 것이 목표입니다. 각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'로 판정됩니다. 예를 들어, 상대방의 숫자가 123일 때 132를 추리하면 1스트라이크 2볼이 됩니다. 이러한 힌트를 활용하여 상대방의 숫자를 추리해 나가는 게임입니다.
### 스파르타코딩클럽 내일배움캠프 iOS 트랙 프로그래밍 심화 주차 과제 수행
- Command Line Tool을 이용합니다.
- 개인 프로젝트 입니다.
***
### 게임 플레이 화면
![Screenshot 2024-11-08 at 18 40 22](https://github.com/user-attachments/assets/f55531b2-a365-4d63-aecd-c69e67190c2c)
***
### 개발과정을 담은 포스팅 시리즈
https://velog.io/@emilyj4482/series/BaseballGame
***
### 디렉토리 구성
- NumberBaseball
  - Helper
    - InputError.swift
    - Messages.swift
  - Manager
    - ManagerType.swift
    - CheckManager.swift
    - RecordManager.swift
  - Model
    - Game.swift
    - Programme.swift
  - main.swift
***
### main.swift
```swift
import Foundation

let programme = Programme()
programme.start()
```
> 프로그램을 실행합니다.
### Programme.swift
```swift
class Programme {
    private let managers: ManagerType
    func start()
    private func chooseAction(_: String)
    private func startGame()
    private func getRecords()
    private func chooseAgain(_: Bool)
    private func exit()
}
```
> - 프로그램을 운영합니다.
> - `ManagerType`을 의존하여 작업 처리에 도움을 받습니다.
> - 사용자의 입력값에 따라 [1] 게임 플레이 [2] 기록 조회 [3] 프로그램 종료 작업을 호출합니다.
> - `Game`을 소유합니다.
### Game.swift
```swift
struct Game {
    private var answer: [Int]
    private var count: Int
    private let managers: ManagerType
    private func createAnswer() -> [Int]
    private mutating func countUp()
    mutating func start()
    private mutating func play()
    private mutating func end()
}
```
> - 단일 게임의 값 타입입니다.
> - `Programme`으로부터 `ManagerType`을 주입 받습니다.
> - `Programme`의 `startGame()`에서 지역변수로 생성되고, `start()` 함수를 호출 받습니다.
> - 게임이 종료되면 `managers.recordManager`를 통해 기록을 남기고 해제됩니다.
### ManagerType.swift
```swift
protocol ManagerType {
    var checkManager: CheckManagerType { get }
    var recordManager: RecordManagerType { get }
}
protocol CheckManagerType {
    func checkInput(_ input: String) -> Result<[Int], InputError>
    func checkAnswer(input: [Int], answer: [Int]) -> Bool
}
protocol RecordManagerType {
    func getRecords()
    func addRecord(_ record: Int)
}
```
> `Programme`과 `Game`이 작업 처리에 도움을 받기 위해 의존하는 타입입니다.
### InputError.swift
```swift
enum InputError: Error {
    case

    var localizedDescription: String {  }
}
```
> Custom Error `enum` 입니다. 예외 처리 시 경우에 따라 특정 에러를 던질 때 사용합니다.
### Messages.swift
```swift
struct Messages {
    static let message: String
}
```
> `CLI` 특성 상 많은 로그 메시지 출력이 이루어지는 만큼, 미리 저장하여 사용할 수 있도록 구성한 구조체입니다.
