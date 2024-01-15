//
//  PresentationModeWrapper.swift
//  connect
//
//  Created by Рауан Аблайхан on 11.01.2024.
//

import Foundation
import SwiftUI

class PresentationModeWrapper: ObservableObject {
    @Published var presentationMode: PresentationMode?
    
    init(presentationMode: PresentationMode?) {
        self.presentationMode = presentationMode
    }
}
