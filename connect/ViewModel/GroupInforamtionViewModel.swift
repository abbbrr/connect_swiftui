import Foundation
import SwiftUI

class GroupInforamtionViewModel:ObservableObject{
    struct Letter: Identifiable {
        var id: Int
        var char: Character
        var isVisible: Bool
    }

    @Published var peoples: [String] = ["Adil", "Max", "Rauan", "Ernar"]
    @Published var word = "Пацанские Историй"
    @Published var isReady = true
    @Published var revealedLetters: [[Letter]] = []
    @Published var highlightedLetterIndex: (row: Int, column: Int)? = nil
    @Published var currentRow = 0
    @Published var activeUserIndex = 0
    @Published var isShetGroupInfo = false

    init() {
        setupRevealedLetters()
    }

    func setupRevealedLetters() {
        revealedLetters = word.split(separator: " ").enumerated().map { (index, wordPart) in
            wordPart.enumerated().map { (charIndex, char) in
                Letter(id: index * 100 + charIndex, char: char, isVisible: index == 0 && charIndex == 0)
            }
        }
    }

    func revealNextLetter() {
        guard let nextRow = nextRowWithInvisibleLetters() else {
            return
        }

        if let highlightedLetterIndex = highlightedLetterIndex {
            revealedLetters[highlightedLetterIndex.row][highlightedLetterIndex.column].isVisible.toggle()
        }

        var nextRowLetters = revealedLetters[nextRow]

        if let index = nextRowLetters.firstIndex(where: { !$0.isVisible }) {
            nextRowLetters[index].isVisible.toggle()
            highlightedLetterIndex = (row: nextRow, column: index)
        }

        revealedLetters[nextRow] = nextRowLetters
        nextUser()
    }

    func nextRowWithInvisibleLetters() -> Int? {
        highlightedLetterIndex = nil

        for rowIndex in currentRow..<revealedLetters.count {
            if revealedLetters[rowIndex].contains(where: { !$0.isVisible }) {
                return rowIndex
            }
        }
        return nil
    }

    func revealAllLetters() {
        for rowIndex in 0..<revealedLetters.count {
            for index in 0..<revealedLetters[rowIndex].count {
                revealedLetters[rowIndex][index].isVisible = true
            }
        }
        
        highlightedLetterIndex = nil
    }

    func handleAnswer() {
        isReady.toggle()
    }

    func nextUser() {
        if activeUserIndex < peoples.count - 1 {
            activeUserIndex += 1
        } else {
            return
        }
    }
}
