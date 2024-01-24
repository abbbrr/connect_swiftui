import SwiftUI

struct SectionUIView: View {
    var sections = [
        SectionModel(name: "Фильмы, Сериалы", description: "актеры, название", color: .green, textColor: "Лёгкий", image: "smile", theme: "Films"),
        SectionModel(name: "Русские термины", description: "русский, термин", color: .red, textColor: "тяжело", image: "bad", theme: "Russ"),
        SectionModel(name: "Аниме", description: "персонажи, название", color: .yellow, textColor: "среднее", image: "normal", theme: "Anime"),
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState:AppState
    
    @State private var selectedSection: SectionModel? = nil
        
    var body: some View {
        VStack{
//         MARK: Section Card
            ScrollView {
                ForEach(sections, id: \.theme){ section in
                    Button(action: {
                        withAnimation {
                            if appState.selectedTheme == section.theme {
                                appState.selectedTheme = nil
                            } else {
                                appState.selectedTheme = section.theme
                                appState.theme = section.theme
                            }
                        }
                     }) {
                         SectionCardView(section: section)
                             .padding()
                             .frame(width: 330, height: 150, alignment: .leading)
                             .overlay(
                                 RoundedRectangle(cornerRadius: 10)
                                    .stroke(appState.selectedTheme == section.theme ? Color.red : Color.gray.opacity(0.5), lineWidth: 0.5)
                                    .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 2)
                             )
                             .padding(.vertical)
                    }
                }
            }
            
           createGroupButton
        }
        .padding()
        .navigationBarTitle("Выбор категорий", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:backButton, trailing: profileButton)
    }
    
    private var isCreateGroupButtonActive: Bool {
         return appState.selectedTheme != nil
     }
     
    private var createGroupButtonColor: Color {
         return isCreateGroupButtonActive ? Color(red: 0.89, green: 0.38, blue: 0.41) : Color(.gray)
     }
    
    private var createGroupButton: some View{
        NavigationLink(destination: CreateGroupUIView()){
            Text("Создать группу")
                .foregroundColor(Color(.white))
                .font(.title2)
                .bold()
        }
        .frame(width: 300, height: 50)
        .foregroundColor(.clear)
        .background(createGroupButtonColor)
        .cornerRadius(16)
        .padding()
        .padding(.bottom)
        .disabled(!isCreateGroupButtonActive)
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    private var profileButton: some View{
        HStack{
            NavigationLink(destination: ProfileUIView()) {
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
            }
        }
    }

}

#Preview {
    SectionUIView()
}
