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
                        .onAppear(){
                            print("group users \(appState.maxMembers)")
                            print("group user \(appState.username)")
                            print("group name \(appState.groupName)")
                            print("group id \(appState.groupId)")
                            print("group theme \(appState.theme)")
                        }
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
