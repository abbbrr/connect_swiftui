import SwiftUI

struct GroupUserUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    @StateObject private var viewModel = GroupInforamtionViewModel()
     
    var maxMembers: Int = 8
        
    var body: some View {
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
            
            Spacer()
            
            if maxMembers == 8{
                VStack(alignment: .center, spacing: 15) {
                    ForEach(viewModel.revealedLetters.indices, id: \.self) { rowIndex in
                        HStack{
                            ForEach(viewModel.revealedLetters[rowIndex]) { letter in
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
                                                letter.isVisible && viewModel.highlightedLetterIndex?.row == rowIndex && viewModel.highlightedLetterIndex?.column == letter.id % 100 ?
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
                    viewModel.setupRevealedLetters()
                }
                .padding()
                .padding(.horizontal)
            } else{
                Text("Ожидание игроков...")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment:.trailing){
                listPeople
            }
            .padding(.bottom,20)
            
            buttonsReady
        }
        .navigationBarTitle("User", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: profileButton)
        .sheet(isPresented: $viewModel.isShetGroupInfo) {
            GroupInfoView()
        }
    }
    
    private var listPeople: some View{
        ForEach(viewModel.peoples.indices, id: \.self){index in
            HStack{
                Image(systemName: viewModel.isReady ? "checkmark" : "multiply")
                    .foregroundColor(viewModel.isReady ? .green : .red)
                    .bold()
                    .frame(width: 20, height: 20)
                
                Text(viewModel.peoples[index])
                    .font(
                        Font.custom("Urbanist", size: index == viewModel.activeUserIndex ?  25 : 18)
                            .weight(.bold)
                    )
                    .foregroundColor(index == viewModel.activeUserIndex ? .black : .gray)
                    .padding(0.5)
                    .padding(.trailing,20)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .onTapGesture {
                if index == viewModel.activeUserIndex {
                    viewModel.handleAnswer()
                    viewModel.nextUser()
                }
            }
        }
    }
    
    private var buttonsReady: some View{
        HStack{
            Button {
                viewModel.handleAnswer()
                viewModel.nextUser()
            } label: {
                Text("Не знаю")
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
                viewModel.handleAnswer()
                viewModel.nextUser()
            } label: {
                Text("Знаю")
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
        .padding()
    }
    
    private var profileButton: some View{
        HStack{
            Button {
                viewModel.isShetGroupInfo = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.black)
            }

        }
    }
}

#Preview {
    GroupUserUIView()
}
