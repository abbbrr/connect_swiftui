import SwiftUI
import Combine

struct HelloUIView: View {
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
//            ButtonAllView(firstText: "Войти в игру!", lastTesxt: "Создать игру!", destination1: ComeInUIView(), destination2: SectionUIView(), firstColor: "comeinColor", lastColor: "createColor")

            ButtonAllView(firstText: "Авторизация", lastTesxt: "Регистрация", destination1: AuthUIView(), destination2: RegisterUIView(), firstColor: "regisColor",lastColor: "regisColor")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HelloUIView()
}
