//
//  HomePage.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        NavigationView{
            HStack{
                NavigationLink(destination: ContentView(vm: vm)){
                    Text("game")
                }
                NavigationLink(destination: SettingsView(vm: vm)){
                    Text("settings")
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomePage()
}
