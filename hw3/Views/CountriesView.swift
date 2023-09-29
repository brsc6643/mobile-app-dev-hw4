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
            Text(String("Car: \(country.car.side)"))
//            if let currency = country.currencies {
//                                    Text("Currency: \(currency.joined(separator: ", "))")
//                                }
//            Text(getLanguages(language: country.language!))
//            Text("Translations: \(country.translations ?? "N/A")")
            
        }
        .navigationTitle("Country Details")
    }
}
 
struct CountriesView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var countries = [Country]()
    @State var selectedCountry: Country?
    @State var isLoading = false
 
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
            //lecture notes
            if isLoading {
                Text("Loading...")
            }
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
                    print("Running task.")
                    await getAllCountries()
                    print("Completed task.")
                }
                if isLoading{
                    ProgressView()
                }
                else {
                    Text("Loading complete.").bold()
                }
            }
            .sheet(item: $selectedCountry) { country in
                CountryDetailView(country: country) // Display the detail view when a country is selected
                Button("Press to dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("Countries")
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: CountrySearchView(countries: $countries)) {
                                    Image(systemName: "magnifyingglass")
                                }
                            }
                        }
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
//    var currencies: [String]?
//    var translations: Array<String>
//    var language: [String: String]?
    var car: Car
}

struct Car: Codable {
    var side: String
}

//func getLanguages(language: [String: String]) -> String {
//    var availableLanguages = ""
//    for (key, value) in language {
//        availableLanguages = ("\(availableLanguages) \(value)")
//    }
//    return availableLanguages
//}
struct CountryName: Codable {
    var common: String
    var official: String
}

struct CountriesView_Previews: PreviewProvider { //previewProvider struct to display preview
    static var previews: some View {
        CountriesView() //initial countriesView displayed in provider
    }
}
