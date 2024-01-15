import SwiftUI

struct ComeInUIView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var text = ""
    @State private var isLoading = false
    @State private var searchResult: String?
    @State private var isClickedGroup = false

    var body: some View {
        VStack {
            HStack {
                TextField("ID группы", text: $text)
                    .font(.title3)
                    .padding(.leading)

                Button {
                    performSearch()
                } label: {
                    Image(systemName: "arrowshape.right.circle")
                        .font(.title)
                        .foregroundColor(text.isEmpty ? .gray : .green)
                        .padding(.trailing)
                }
                .disabled(text.isEmpty)
            }
            .frame(width: 300, height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
            }
            .padding()
            .padding(.vertical)

            if isLoading {
                Spacer()
                ProgressView()
                    .scaleEffect(1.5)
                    .animation(
                        Animation
                            .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: UUID()
                    )
                Spacer()
            } else {
                if let result = searchResult{
                    Button(action: {
                        self.isClickedGroup.toggle()
                    }) {
                        GroupDetailsView(groupName: "Бека Лох", groupCode: result)
                            .frame(width: 300, height: 250)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(isClickedGroup ? Color.red.opacity(0.5) : Color.black.opacity(0.5), lineWidth: 1)
                            )
                    }
                } else{
                    Spacer()
                    Text("Список пуст")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            
            Spacer()

            NavigationLink(destination: RegisterUIView()) {
                Text("Войти игру")
                    .foregroundColor(Color(.white))
                    .font(.title2)
                    .bold()
            }
            .frame(width: 300, height: 50)
            .foregroundColor(.clear)
            .background(!isClickedGroup ? Color.gray : Color(red: 0.89, green: 0.38, blue: 0.41))
            .cornerRadius(16)
            .padding()
            .padding(.vertical)
            .disabled(!isClickedGroup)
        }
        .navigationBarTitle("Войти в игру", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: profileButton)
    }

    private func performSearch() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            searchResult = Bool.random() ? "232323" : nil
        }
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }

    private var profileButton: some View {
        NavigationLink(destination: ProfileUIView()) {
            Image(systemName: "person.circle")
                .foregroundColor(.black)
        }
    }
}

struct GroupDetailsView: View {
    let groupName: String
    let groupCode: String

    var body: some View {
        VStack(spacing: 10) {
            Text(groupName)
                .bold()
                .font(.title)
                .foregroundColor(.black)

            Text("Код группы: \(groupCode)")
                .font(.title3)
                .foregroundColor(.gray)

            Text("Тема игры: Аниме")
                .font(.title3)
                .foregroundColor(.gray)

            Text("5 человек")
                .font(.title3)
                .foregroundColor(.gray)
        }
    }
}

struct ComeInUIView_Previews: PreviewProvider {
    static var previews: some View {
        ComeInUIView()
    }
}
