import SwiftUI

struct SectionUIView: View {
    var sections = [
        SectionModel(name: "Фильмы, Сериалы", description: "актеры, название", color: .green, textColor: "Лёгкий", image: "smile", theme: "Films"),
        SectionModel(name: "Русские термины", description: "русский, термин", color: .red, textColor: "тяжело", image: "bad", theme: "Russ"),
        SectionModel(name: "Аниме", description: "персонажи, название", color: .yellow, textColor: "среднее", image: "normal", theme: "Anime"),
    ]
    
    
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedSection: SectionModel? = nil

    @State private var section = false
    
    @Binding var theme: String
    @Binding var groupName: String
    @Binding var maxMembers: Int
        
    var body: some View {
        VStack{
//         MARK: Section Card
            ScrollView {
                ForEach(sections){ section in
                    Button(action: {
                        if selectedSection == section {
                            selectedSection = nil
                        } else {
                           selectedSection = section
                            theme = section.theme
                        }
                     }) {
                         SectionCardView(section: section, isSelected: selectedSection == section)
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
         return selectedSection != nil
     }
     
    private var createGroupButtonColor: Color {
         return isCreateGroupButtonActive ? Color(red: 0.89, green: 0.38, blue: 0.41) : Color(.gray)
     }
    
    private var createGroupButton: some View{
        NavigationLink(destination: CreateGroupUIView(theme: $theme, groupName: $groupName, maxMembers: $maxMembers)){
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
    SectionUIView(theme: .constant(nil ?? ""), groupName: .constant(nil ?? ""), maxMembers: .constant(nil ?? 0))
}
