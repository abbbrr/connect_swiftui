import SwiftUI

struct GroupDetailsUIView: View{
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    
    @StateObject private var viewModel = GroupInforamtionViewModel()
        
    var body: some View {
        VStack{
            VStack(alignment:.trailing){
                ForEach(viewModel.peoples, id: \.self){people in
                    HStack{
                        Image(systemName: viewModel.isReady ? "checkmark" : "multiply")
                            .foregroundColor(viewModel.isReady ?  .green : .red)
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
                        viewModel.revealAllLetters()
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
                        viewModel.revealNextLetter()
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
        .sheet(isPresented: $viewModel.isShetGroupInfo) {
            GroupInfoView()
        }
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
    GroupDetailsUIView()
}
