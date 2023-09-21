//
//  SearchView.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//

import Foundation
import SwiftUI


func getSwedenInfo() async -> () {
    do {
        let url = URL(string: "https://restcountries.com/v3.1/name/sweden")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let sweden = try JSONDecoder().decode([Country].self, from: data)
        if let swedenInfo = sweden.first {
            print("Sweden Info:")
            print("Common Name: \(swedenInfo.name.common)")
            print("Official Name: \(swedenInfo.name.official)")
            if let capital = swedenInfo.capital?.first {
                print("Capital: \(capital)")
            }
            print("Flag: \(swedenInfo.flag)")
            print("Population: \(swedenInfo.population)")
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
 
struct SearchView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Country of the Day is:")
                    .font(.largeTitle)
                    .padding()
                Text("Sweden!")
                    .font(.largeTitle)
                    .padding()
                Button("Fetch Sweden Info"){
                    Task{
                        await getSwedenInfo() //not working properly at the moment, not sure why 
                    }
                }
            }
             //use the await keyword to grab info from a specific country by calling a different function
        }
    }
    @MainActor
    class UISearchBar : UIView{}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some
    View {
        SearchView()
    }
}
