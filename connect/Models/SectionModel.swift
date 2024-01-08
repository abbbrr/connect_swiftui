import Foundation
import SwiftUI

struct SectionModel: Identifiable, Hashable{
    let id = UUID()
    let name: String
    let description: String
    let color: Color
    let textColor: String
    let image:String
}
