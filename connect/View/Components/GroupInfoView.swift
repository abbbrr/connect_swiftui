import SwiftUI

struct GroupInfoView: View {
    @EnvironmentObject var appState:AppState
    var peoples: [String] = ["Adil", "Max", "Rauan", "Ernar", "Arman"]
    
    var body: some View {
        VStack{
//            Text("Имя группы: \(appState.groupName)")
            Text("Имя группы: вфывфв")
                .bold()
                .font(.title2)
            
//            Text("ID группы: \(appState.groupId )")
            Text("ID группы: 123123")
                .foregroundColor(.gray)
            
//            themeSeleceted
            Text("Тема: Русские термины")
                .foregroundColor(.gray)

            
            VStack{
                Text("Участники:")
                    .bold()
                    .font(.title2)
                
                ForEach(0..<Swift.max(peoples.count, appState.maxMembers), id: \.self) { index in
                    let participant:String
                    if index < peoples.count {
                        let participant1 = peoples[index]
                        participantView(participant: participant1)
                            .padding(0.5)
                            .padding(.trailing, 20)
                    } else {
                        let participant2 = "Ожидание игрока"
                        participantView(participant: participant2)
                            .padding(0.5)
                            .padding(.trailing, 20)
                    }
                }
            }
            .padding()
            
            Text("Создатель группы : Arman")
                .bold()
                .font(.title3)
        }
    }
    
    private func participantView(participant: String) -> some View {
        if participant == "Ожидание игрока" {
            return AnyView(
                HStack(spacing: 4) {
                    Text(participant)
                        .font(.custom("Urbanist", size: 22).weight(.bold))
                        .foregroundColor(.gray)

                    ForEach(0..<3) { _ in
                        Text(".")
                            .font(.custom("Urbanist", size: 22).weight(.bold))
                            .foregroundColor(.gray)
                           
                    }
                }
            )
        } else {
            return AnyView(
                Text(participant)
                    .font(.custom("Urbanist", size: 22).weight(.bold))
                    .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
            )
        }
    }
    
    
//    private var themeSeleceted: some View{
//        VStack{
//            if appState.theme == "Russ"{
//                Text("Тема: Русские термины")
//                    .foregroundColor(.gray)
//            } else if appState.theme == "Anime"{
//                Text("Тема: Аниме")
//                    .foregroundColor(.gray)
//            } else if appState.theme == "Films"{
//                Text("Тема: Фильмы, Сериалы")
//                    .foregroundColor(.gray)
//            }
//        }
//    }
    
}


#Preview {
    GroupInfoView()
}
