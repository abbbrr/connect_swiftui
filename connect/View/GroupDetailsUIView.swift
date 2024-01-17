import SwiftUI

struct GroupDetailsUIView: View {
    struct Letter: Identifiable {
        var id: Int
        var char: Character
        var isVisible: Bool
    }

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    
    var peoples: [String] = ["Adil", "Max", "Rauan", "Ernar"]
    var word = "Пацанские Историй"
    
    @State private var isReady = true
    @State private var currentRow = 0
    @State private var revealedLetters: [[Letter]] = []
    @State private var highlightedLetterIndex: (row: Int, column: Int)? = nil
    
    @State private var isShetGroupInfo = false
    
    var body: some View {
        VStack{
            VStack(alignment:.trailing){
                ForEach(peoples, id: \.self){people in
                    HStack{
                        Image(systemName: isReady ? "checkmark" : "multiply")
                            .foregroundColor(isReady ?  .green : .red)
                            .bold()
                            .frame(width: 20, height: 20)
                        
                        Text(people)
                            .font(
                                Font.custom("Urbanist", size: 18)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                            .padding(0.5)
                            .padding(.trailing,20)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.top)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 15) {
                ForEach(revealedLetters.indices, id: \.self) { rowIndex in
                    HStack{
                        ForEach(revealedLetters[rowIndex]) { letter in
                            Text(letter.isVisible ? String(letter.char) : "*")
                                .font(
                                    Font.custom("Urbanist", size: 19)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                                .frame(width: 32, height: 33)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.98))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(
                                            letter.isVisible && highlightedLetterIndex?.row == rowIndex && highlightedLetterIndex?.column == letter.id % 100 ?
                                                    Color(red: 0.21, green: 0.76, blue: 0.76) :
                                                    Color(red: 0.91, green: 0.93, blue: 0.96),
                                                lineWidth: 1
                                        )
                                )
                        }
                    }
                }
            }
            .onAppear {
                revealedLetters = word.split(separator: " ").enumerated().map { (index, wordPart) in
                    wordPart.enumerated().map { (charIndex, char) in
                        Letter(id: index * 100 + charIndex, char: char, isVisible: index == 0 && charIndex == 0)
                    }
                }
            }
            .padding()
            .padding(.horizontal)
            
            Spacer()
            
            VStack{
                Text("Arman")
                    .font(
                        Font.custom("Urbanist", size: 22)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                .foregroundColor(.clear)
                .frame(width: 85, height: 85)
                .background(Color(red: 0.97, green: 0.97, blue: 0.98))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.91, green: 0.93, blue: 0.96), lineWidth: 1)
                )
                .padding()
                
                HStack{
                    Button {
                        revealAllLetters()
                    } label: {
                        Text("Раскрыть слово")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 125, height: 55)
                    .background(Color("createColor"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.91, green: 0.93, blue: 0.96), lineWidth: 1)
                    )
                    
                    Button {
                        revealNextLetter()
                    } label: {
                        Text("Буква")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 125, height: 55)
                    .background(Color("comeinColor"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.91, green: 0.93, blue: 0.96), lineWidth: 1)
                    )

                }
            }
            .padding()
        }
//        .navigationBarTitle("\(appState.groupName)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: profileButton)
        .sheet(isPresented: $isShetGroupInfo) {
            GroupInfoView()
        }
    }
    
    
    private func revealNextLetter() {
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
    }


    private func nextRowWithInvisibleLetters() -> Int? {
        highlightedLetterIndex = nil

        for rowIndex in currentRow..<revealedLetters.count {
            if revealedLetters[rowIndex].contains(where: { !$0.isVisible }) {
                return rowIndex
            }
        }
        return nil
    }

    private func revealAllLetters() {
        for rowIndex in 0..<revealedLetters.count {
            for index in 0..<revealedLetters[rowIndex].count {
                revealedLetters[rowIndex][index].isVisible = true
            }
        }
        
        highlightedLetterIndex = nil
    }

    
    private var profileButton: some View{
        HStack{
            Button {
                isShetGroupInfo = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.black)
            }

        }
    }
}

#Preview {
    GroupDetailsUIView()
}
