import SwiftUI

struct SectionUIView: View {
    var sections = [
//        SectionModel(name: "Кулинария", description: "рецепты, еда", color: .yellow, textColor: "среднее", image: "normal"),
        SectionModel(name: "Фильмы, Сериалы", description: "актеры, название", color: .green, textColor: "Лёгкий", image: "smile"),
        SectionModel(name: "Русские термины", description: "русский, термин", color: .red, textColor: "тяжело", image: "bad"),
        SectionModel(name: "Аниме", description: "персонажи, название", color: .yellow, textColor: "среднее", image: "normal"),
    ]
    
    @Environment(\.presentationMode) var presentationMode
    var helloView: String

    @State private var selectedSection: SectionModel? = nil
    
    init(helloView: String) {
        self.helloView = helloView
    }

    
    var body: some View {
        VStack{
//         MARK: Section Card
            ForEach(sections){ section in
                Button(action: {
                    if selectedSection == section {
                        selectedSection = nil
                    } else {
                        selectedSection = section
                    }
                 }) {
                     SectionCardView(section: section, isSelected: selectedSection == section)
                }
            }
        }
        .padding()
        .navigationBarTitle("Выбор категорий", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    if helloView == "Light Mode"{
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }else {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                }
            }
        )
    }
}

#Preview {
    SectionUIView(helloView: "Dark Mode")
}
