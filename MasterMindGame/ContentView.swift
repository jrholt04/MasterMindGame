//File: ContentView
//Jackson Holt
//CS 3164, Winter 2024
//
//  ContentView.swift
//  MasterMindGame
//
//  VIEW
//
//  Created by Jackson Holt on 1/16/24.
// this is the view file for what the master mind game will look like
//

import SwiftUI

//array of colors for the circles

struct ContentView: View {
    
    //viewable classs view model
    @ObservedObject var vm = ViewModel()
    
    var body: some View {
        
        VStack{
            // title of game
            Text("MASTERMIND")
                .font(.system(size: 20))
                .bold()
            
            
            ForEach(vm.userGuesses){ guessNumber in
                CircleGuessRow(row: guessNumber.id)
            }
            .padding()
            
            
            
            Text("choose a color: ")
                .font(.system(size: 15))
                .bold()
            HStack {
                
                //foreach for all the circles in the selection row
                ForEach(vm.circleOptions) {thisCircle in
                    CircleOptionView(colorInt: thisCircle.id, isSelected: thisCircle.isSelected)
                    //on the tap we get to see the circles outline bold when it is selected and unbolcd when it is not
                        .onTapGesture(perform: {
                            //choose a circle
                            vm.chooseCircle(circleNumber: thisCircle.id)
                            print("VIEW: trying to choose letter number \(thisCircle.id)")
                        })
                }
            }
            .padding()
            //user prompt
            
        }
    }
    
    //struct that holds all of the data for and states of the cirlces in the guess row
    struct CircleOptionView: View {
        var colorInt : Int
        var isSelected: Bool
        
        var body: some View{
            ZStack{
                //background circle
                Circle()
                    .stroke(lineWidth: isSelected ? 12 : 6 )
                    .foregroundColor(Color.black)
                //main circle
                Circle()
                    .foregroundColor(colorArray[colorInt])
                
            }
        }
        
        
        
    }
    
    //view for a single circle of a users guess
    struct CircleGuessView: View{
        var CircleId: Int?
        
        var body: some View{
            if let CircleNumber = CircleId{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 6 )
                        .foregroundColor(Color.black)
                    //main circle
                    Circle()
                        .foregroundColor(colorArray[CircleNumber])
                    
                }
            }
            else {
                ZStack{
                    Circle()
                        .stroke(lineWidth: 6 )
                        .foregroundColor(Color.black)
                    //main circle
                    Circle()
                        .foregroundColor(Color.white)
                }
            }
        }
    }
    
    // a struct for an entire guess row
    struct CircleGuessRow: View {
        var row: Int
        
        var body: some View {
            HStack{
                CircleGuessView()
                CircleGuessView()
                CircleGuessView()
                CircleGuessView()
                

                
            }
        }
    }
    
       
}


                    
                    
                    
                    
                    
                    
#Preview {
    ContentView()
}
