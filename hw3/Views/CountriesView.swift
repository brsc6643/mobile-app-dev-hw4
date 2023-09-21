//
//  CountriesView.swift
//  hw3
//
//  Created by Broderick Ryan Schmidt on 9/15/23.
//

import Foundation
import SwiftUI

        
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

        struct CountriesView: View {
            @Environment(\.dismiss) var dismiss
            
            @State var countries = [Country]() //declare a state variable countries that is set to the struct [Country]()
            
            
            //define a function getAllCountries as an asynchronous function that will wait for the data to arrive to the program
            //asynchronous calls instruct the program to wait for the data to be retreived before continuing to other methods
            //methods flagged with the async instruction must have an await instruction that will wait for the asynchronous call to be completed before execution continues
            func getAllCountries() async -> () {
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
            
            var body: some View { //declare body and view
                NavigationView {
                    VStack{
                        Text("Please browse the world's countries below.")
                        
                        Button("Press to dismiss") {
                            dismiss()
                        }
                        
                        List(countries) { country in
                            VStack(alignment: .leading) {
                                Text("\(country.flag) * \(country.name.common)") //access the country struct, the name of the country, and within the countryName struct access the common variable
                            }
                        }
                        .task{
                            await getAllCountries()
                        }
                        .toolbar {
                            Button("Fetch Sweden Info") {
                                Task{
                                    await getSwedenInfo()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Countries")
            } //end body
        }

        struct CountriesView_Previews: PreviewProvider { //previewProvider struct to display preview
            static var previews: some View {
                CountriesView() //initial countriesView displayed in provider
            }
        }
