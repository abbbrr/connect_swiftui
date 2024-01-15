import SwiftUI

struct ButtonAllView<Destination1: View, Destination2: View>: View {
    var firstText:String
    var lastTesxt:String
    
    var destination1: Destination1
    var destination2: Destination2
    
    var firstColor:String
    var lastColor:String
    
    var body: some View {
        HStack{
            NavigationLink(destination: destination1){
                Text(firstText)
                    .foregroundColor(firstColor == "comeinColor" ? Color(.white) : Color(firstColor))
                    .font(.title2)
                    .bold()
            }
            .frame(width: 170, height: 60)
            .foregroundColor(.clear)
            .background(
                firstColor == "comeinColor" ?
                    Color("comeinColor") :
                    Color(red: 1, green: 0.99, blue: 0.99)
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Color(red: 0.92, green: 0.9, blue: 0.91), lineWidth: 1.5)
            )
            
            NavigationLink(destination: destination2) {
                Text(lastTesxt)
                    .foregroundColor(Color(.white))
                    .font(.title2)
                    .bold()
            }
            .frame(width: 170, height: 60)
            .foregroundColor(.clear)
            .background(Color(lastColor))
            .cornerRadius(16)
        }
        .padding()
        .padding(.bottom,10)
    }
}
//
//#Preview {
//    ButtonAllView(firstText: "Авторизация", lastTesxt: "Регистрация", destination1: ContentView(), destination2: ContentView(), firstColor: "regisColor",lastColor: "regisColor")
//}
