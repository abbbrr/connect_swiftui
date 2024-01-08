import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var helloView = "Light Mode"
    
    @State private var films: [String] = []
    
    var body: some View {
        NavigationView{
            VStack{
                HelloUIView(helloView: helloView)
            }
            .onAppear {
                if colorScheme == .dark {
                    helloView = "Dark Mode"
                } else {
                    helloView = "Light Mode"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
