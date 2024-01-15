
import SwiftUI

struct CreategroupLabelView: View {
    @State private var nameGroup = ""
    
    var body: some View {
        VStack(alignment:.leading){
            VStack(spacing:10){
                Text("Настройки группы")
                    .bold()
                    .font(.title2)
                
                Text("В приведенном выше примере цвет")
                    .font(
                        Font.custom("Overpass", size: 14)
                        .weight(.thin)
                    )
                    .foregroundColor(.gray)
                    .padding(.leading,35)
            }
           
            TextField("Название группы", text: $nameGroup)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

#Preview {
    CreategroupLabelView()
}
