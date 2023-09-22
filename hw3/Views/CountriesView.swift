//
//  CountriesView.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//
//

import SwiftUI
 
struct CountryDetailView: View {
    let country: Country
 
    var body: some View {
        VStack(alignment: .leading) {
            Text("Common Name: \(country.name.common)")
            Text("Official Name: \(country.name.official)")
            Text("Capital: \(country.capital?.joined(separator: ", ") ?? "N/A")")
            Text("Population: \(country.population)")
            Image(systemName: country.flag) // Assuming flag is a system image name
                .resizable()
                .frame(width: 50, height: 30)
        }
        .navigationTitle("Country Details")
    }
}
 
struct CountriesView: View {
    @Environment(\.dismiss) var dismiss
 
    @State var countries = [Country]()
    @State var selectedCountry: Country?
 
    func getAllCountries() async {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            //use let to assign shared data from the url into the variable data
            //use the await instruction to allow the data from the URL to be retrieved before continuing with execution
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data) //print the data to see where we are
            //use a try and catch block with JSONDecoder(),decode([JSONstruct].self, from: data to decode JSON above
            countries = try JSONDecoder().decode([Country].self, from: data)
        }
        catch { //catch errors by outputting the appropriate error description
            print("Error: \(error.localizedDescription)")
        }
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Text("Please browse the world's countries below.")
 
                Button("Press to dismiss") {
                    dismiss()
                }
 
                List(countries) { country in
                    VStack(alignment: .leading) {
                        Button(action: {
                            selectedCountry = country // Set the selected country
                        }) {
                            Text("\(country.flag) \(country.name.common) \n Official Name: \(country.name.official)")
                        }
                    }
                }
                .task {
                    await getAllCountries()
                }
            }
            .sheet(item: $selectedCountry) { country in
                CountryDetailView(country: country) // Display the detail view when a country is selected
                Button("Press to dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("Countries")
        }
    }
}

struct Country: Codable, Identifiable {   //label the Country struct as codable and identifiable
    //identifiable labels must have an id variable
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var capital: [String]?
    var flag: String
    var population: Int
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct CountriesView_Previews: PreviewProvider { //previewProvider struct to display preview
    static var previews: some View {
        CountriesView() //initial countriesView displayed in provider
    }
}
