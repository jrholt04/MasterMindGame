//
//  HomeView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//
// this is the home page with all of the navigation
//refrence: https://youtu.be/D0siMqCwMJY
import SwiftUI

struct HomeView: View {
   
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        //navigation stack for the home page to go to settings or game
        NavigationView{
            ZStack{
                confettiMain()
                VStack{
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
                    
                    NavigationLink(destination: ContentView(vm: vm)){
                        ZStack{
                            RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                                .fill(.black)
                                .scaledToFit()
                                .frame(width: 400, height: 100)
                            Text("PLAY")
                                .font(.system(size: CGFloat(TEXTSIZE / 2)))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .padding()
                    NavigationLink(destination: SettingsView(vm: vm, colorPallet: vm.colorPallet)){
                        ZStack{
                            RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                                .fill(.black)
                                .scaledToFit()
                                .frame(width: 400, height: 100)
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
