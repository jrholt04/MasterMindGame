//
//  HomeView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//
// this is the home page with all of the navigation
//refrence: https://youtu.be/D0siMqCwMJY and https://www.hackingwithswift.com/books/ios-swiftui/adding-a-navigation-bar
//
//   this is the the home view that allows the user to navigate between all the views
//
import SwiftUI

struct HomeView: View {
   
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        //navigation stack for the home page to go to settings or game
        NavigationView{
            ZStack{
                //confetti for the backgorund
                confettiMain()
                VStack{
                    // title for the game
                    ZStack{
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .fill(.black)
                        Text("🔴🟠🟡MASTERMIND🟢🔵🟣")
                            .bold()
                            .font(.system(size: CGFloat(TEXTSIZE)))
                            .padding()
                            .foregroundColor(.white)
                            
                    }
                    .scaledToFit()
                    .padding()
                    
                    //these are nav links to the game page and the settings page 
                    NavigationLink(destination: ContentView(vm: vm)){
                        ZStack{
                            RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                                .fill(.black)
                                .scaledToFit()
                                .frame(width: CGFloat(WIDTH), height: CGFloat(SHEIGHT))
                            Text("PLAY")
                                .font(.system(size: CGFloat(TEXTSIZE / 2)))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding()
                    // this is the nav link for the settings view 
                    NavigationLink(destination: SettingsView(vm: vm, colorPallet: vm.colorPallet)){
                        ZStack{
                            RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                                .fill(.black)
                                .scaledToFit()
                                .frame(width: CGFloat(WIDTH), height: CGFloat(SHEIGHT))
                            Text("settings")
                                .font(.system(size: CGFloat(TEXTSIZE / 2)))
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                    }
                }
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomeView()
}
