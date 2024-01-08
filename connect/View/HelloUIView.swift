import SwiftUI

struct HelloUIView: View {
    @State private var nextScreen = false
    
    var helloView: String

    init(helloView: String) {
        self.helloView = helloView
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Project Name")
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
            
            NavigationLink(destination: SectionUIView(helloView: helloView)) {
                Text("Начать игру!")
                    .foregroundColor(Color(.white))
                    .font(.title2)
                    .bold()
            }
            .frame(width: 300, height: 50)
            .foregroundColor(.clear)
            .background(Color(red: 0.89, green: 0.38, blue: 0.41))
            .cornerRadius(16)
            .padding(.bottom)
            .padding()
        }
    }
}

#Preview {
    HelloUIView(helloView: "Dark Mode")
}
