import SwiftUI

struct ContentView: View {
    @State var switched: Bool = false
    @State private var showingSheet = false
    @State private var showAlert = false
    @State private var searchpage = false
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        VStack{
            
            NavigationView() {
                NavigationLink(destination: SearchView()) {
                    Text("Search").padding().background(Color.accentColor)
                        .foregroundColor(.white)
                }
                .navigationBarTitle("Home Page", displayMode: .inline)
            }
            
            VStack {
                HStack {
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Image(systemName: "person")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                }
                .padding()
                
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Text("Let's get started!")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white))
                
                Text("Tap something to interact with the app.")
                    .padding()
                
                Toggle("", isOn: $switched)
                    .foregroundColor(Color.accentColor)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .frame(width: 60, height: 30, alignment: .center)
                
                if switched {
                    Text("Your journey begins.")
                        .foregroundColor(Color.accentColor)
                }
                
                Button("Display Countries") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    CountriesView()
                }
            }
            TabView {
                LightModeView(colorScheme: $colorScheme)
                    .tabItem {
                        Label("Light Mode Ready", systemImage: "sun.max.fill")
                    }
                
                DarkModeView(colorScheme: $colorScheme)
                    .tabItem {
                        Label("Dark Mode Ready", systemImage: "moon.fill")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colorScheme: .constant(.light))
    }
}
