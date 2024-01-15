import SwiftUI

struct GroupInfoView: View {
    @Binding var theme: String
    @Binding var groupName: String
    @ObservedObject var viewModel = GroupViewModel()
    
    var peoples: [String] = ["Adil", "Max", "Rauan", "Ernar", "Arman"]
    
    var body: some View {
        VStack{
            Text("Grop Name: \(viewModel.groupName ?? "N/A")")
                .bold()
                .font(.title2)
            
            Text("Group ID: \(viewModel.groupID ?? "N/A")")
                .foregroundColor(.gray)
            
            Text("Theme: \(viewModel.theme ?? "N/A")")
                .foregroundColor(.gray)
            
            VStack{
                Text("Участники:")
                    .bold()
                    .font(.title2)
                ForEach(peoples, id: \.self){people in
                    Text(people)
                        .font(
                            Font.custom("Urbanist", size: 22)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                        .padding(0.5)
                        .padding(.trailing,20)
                }
            }
            .padding()
            
            Text("Создатель группы : Arman")
                .bold()
                .font(.title3)
        }
    }
}

#Preview {
    GroupInfoView(theme: .constant(nil ?? ""), groupName: .constant(nil ?? ""))
}
