import SwiftUI

struct CreateGroupUIView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var groups: [String] = []
    @State private var isShowCreateGroup = false
    
    @FocusState private var isFocused: Bool
    
    @Binding var theme: String
    @Binding var groupName: String
    @Binding var maxMembers: Int
    
    var body: some View {
        VStack{
            VStack{
                ForEach(groups.indices, id: \.self){ index in
                    HStack{
                        TextField("Название группы", text: $groups[index])
                            .font(.title3)
                            .padding(.leading)
                            .focused($isFocused)

                        Spacer()
                        
                        Button {
                            groups.remove(at: index)
                        } label: {
                            Image(systemName: "multiply.circle")
                                .font(.title2)
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                    }
                    .frame(width: 300, height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                    }
                    .padding()
                    
                }
                                
                Button(action: {
                    withAnimation(nil){
                        groups.append("")
                        isFocused = true
                    }
                    
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(groups.isEmpty ? .black : .gray)
                        Text("Добавить группу")
                            .font(.title3)
                            .foregroundColor(groups.isEmpty ? .black : .gray)
                    }
                    .frame(width: 300, height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                    }
                    .padding()
                })
                .padding()
                .disabled(!groups.isEmpty)
                
            }
                        
            Spacer()
        
            NavigationLink(destination: PeoplePointUIView(theme: $theme, maxMembers: $maxMembers, groupName: Binding(
                get: {
                    groups.first ?? ""
                },
                set: { newValue in
                    groups = [newValue]
                }
            ))){
                Text("Создать группу")
                    .foregroundColor(Color(.white))
                    .font(.title2)
                    .bold()
            }
            .frame(width: 300, height: 50)
            .foregroundColor(.clear)
            .background(groups.isEmpty || groups.allSatisfy { $0.isEmpty } ? Color.gray : Color(red: 0.89, green: 0.38, blue: 0.41))
            .cornerRadius(16)
            .padding()
            .padding(.vertical)
            .disabled(groups.isEmpty || groups.allSatisfy { $0.isEmpty })
        }
        .navigationBarTitle("Создание группы", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton,trailing: profileButton)
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        }
    }
    
    private var profileButton: some View{
        HStack{
            NavigationLink(destination: ProfileUIView()) {
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    CreateGroupUIView(theme: .constant(nil ?? ""), groupName: .constant(nil ?? ""), maxMembers: .constant(nil ?? 0))
}

