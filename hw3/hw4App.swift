//
//  hw3App.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//
import Foundation
import SwiftUI

@main
struct hw3: App {
    @State private var colorScheme : ColorScheme = .light
    
    var body: some Scene {
        WindowGroup {
            ContentView(colorScheme: $colorScheme)
                .preferredColorScheme(colorScheme)
        }
    }
}
