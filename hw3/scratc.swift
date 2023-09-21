//
//  scratc.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//

import Foundation
import SwiftUI

struct ScratchView: View {
    @State private var selection = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                Text("Hello").tag(0)
                Text("World").tag(1)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            Button("next") {
                withAnimation {
                    selection = 1
                }
            }
        }
    }
}
