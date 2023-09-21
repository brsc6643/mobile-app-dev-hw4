//
//  LightModeView.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//

import Foundation
import SwiftUI


struct LightModeView: View {
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Text("Light Mode Ready")
                .font(.largeTitle)
            
            Button("Tap here to switch to Light Mode") {
                colorScheme = .light
            }
            .padding()
        }
    }
}
