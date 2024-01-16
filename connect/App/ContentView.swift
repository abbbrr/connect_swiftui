import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var isActiveLink = false
    
    var body: some View {
        NavigationView{
            VStack{
                if !appState.shouldNavigateToHelloView{
                    HelloUIView()
                } else if isActiveLink{
                    GroupDetailsUIView()
                }else{
                    ProgressView("Создается группа...")
                }
            }
            .onAppear{
                if appState.shouldNavigateToHelloView{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        isActiveLink = true
                    }
                }
            }
        }
    }

}
