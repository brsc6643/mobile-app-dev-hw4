//
//  DarkModeView.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//

import Foundation
import SwiftUI
    
    
struct DarkModeView: View {
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Text("Dark Mode Ready")
                .font(.largeTitle)
            
            Button("Tap here to switch to Dark Mode") {
                colorScheme = .dark
            }
            .padding()
        }
    }
}
