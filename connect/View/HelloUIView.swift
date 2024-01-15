import SwiftUI
import Combine

struct HelloUIView: View {
    @Binding var theme: String
    @Binding var groupName: String
    @Binding var maxMembers: Int
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Connect Game")
                .bold()
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .padding()
            
            Text("Главной особенностью этого сида является редкая и необычная местность на спавне!")
                .padding()
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .font(.title3)
            
            Spacer()
            ButtonAllView(firstText: "Войти в игру!", lastTesxt: "Создать игру!", destination1: ComeInUIView(), destination2: SectionUIView(theme: $theme, groupName: $groupName, maxMembers: $maxMembers), firstColor: "comeinColor", lastColor: "createColor")
//
//            ButtonAllView(firstText: "Авторизация", lastTesxt: "Регистрация", destination1: AuthUIView(), destination2: RegisterUIView(), firstColor: "regisColor",lastColor: "regisColor")
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            print(theme)
            print(groupName)
            print(maxMembers)
        }
    }
}

#Preview {
    HelloUIView(theme: .constant(nil ?? ""), groupName: .constant(nil ?? ""), maxMembers: .constant(nil ?? 0))
}
