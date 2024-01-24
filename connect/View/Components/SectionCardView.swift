import SwiftUI

struct SectionCardView: View {
    var section: SectionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(section.name)
                .foregroundColor(.black)
                .font(.title2)
                .bold()
            
            HStack{
                Text(section.description)
                    .foregroundColor(Color(.gray))
                    .font(.body)
            }
            
            HStack(spacing:10){
                Image("\(section.image)")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                Text(section.textColor)
                    .font(.body)
                    .foregroundColor(section.color.opacity(0.8))
            }
            .frame(width: 110, height: 40)
            .background(section.color.opacity(0.3))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(section.color.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

