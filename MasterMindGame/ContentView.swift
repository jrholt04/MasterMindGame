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
                .font(.system(size: CGFloat(TEXTSIZE)))
                .bold()
                .onTapGesture {
                    vm.restartGame()
                }
            //these are the guesses
            ForEach(vm.userGuesses){ guessNumber in
                HStack{
                    feedBack(row: guessNumber.id, vm: vm)
                    CircleGuessRow(row: guessNumber.id, vmLocal: vm)
                        .onTapGesture {
                            //print("VIEW: trying to select \(guessNumber.id)")
                            vm.chooseRow(rowNumber: guessNumber.id)
                        }
                }
                
            }
            .padding()
            
            //this is the selection row of colors 
            switch vm.gameState{
            case .playing:
                Text("choose a color: ")
                    .font(.system(size: CGFloat(TEXTSIZE)))
                    .bold()
            case .won:
                Text("You won: ")
                    .font(.system(size: CGFloat(TEXTSIZE)))
                    .bold()
            case .lost:
                Text("You Lost ")
                    .font(.system(size: CGFloat(TEXTSIZE)))
                    .bold()
            }
            HStack {
                //foreach for all the circles in the selection row
                ForEach(vm.circleOptions) {thisCircle in
                    CircleOptionView(colorInt: thisCircle.id, isSelected: thisCircle.isSelected)
                    //on the tap we get to see the circles outline bold when it is selected and unbolcd when it is not
                        .onTapGesture(perform: {
                            //choose a circle
                            vm.chooseCircle(circleNumber: thisCircle.id)
                            //print("VIEW: trying to choose letter number \(thisCircle.id)")
                        })
                }
                //enter key
                makeEnterKeyBody(state: vm.userGuesses[vm.currentRow].isFullGuess ? .enabled : .disabled)
                    .onTapGesture{
                        if vm.userGuesses[vm.currentRow].isFullGuess {
                            //print("VIEW: current row is full -- on to next row")
                            vm.nextRow()
                        }
                    }
                }
                .padding()
        }
        .overlay(gameOverOverlay)
    }
    
    //game over overlay this displays the state of the game whne it is over
    @ViewBuilder var gameOverOverlay: some View {
        switch vm.gameState {
        case .playing:
            Text("")
                .bold()
                .foregroundColor(.clear)
                .background(.clear)
                .font(.system(size: 86))
        case .won:
            Text("YOU WON")
                .bold()
                .foregroundColor(.black)
                .background(.green)
                .font(.system(size: 86))
        case .lost:
            VStack{
                Text("GAME OVER")
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 86))
                HStack{
                    ForEach(0..<CIRCLE_GUESS_COUNT, id:\.self) { i in
                        CircleGuessView(CircleId: vm.secretCode[i].colorOfBead, outlineWidth: OUTLINESIZE)
                    }
                    .padding()
                }
            }
            .background(.red)
            
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
        var outlineWidth: Int
        var body: some View{
            if let CircleNumber = CircleId{
                ZStack{
                    Circle()
                        .stroke(lineWidth: CGFloat(outlineWidth) )
                        .foregroundColor(Color.black)
                    //main circle
                    Circle()
                        .foregroundColor(colorArray[CircleNumber])
                    
                }
            }
            else {
                ZStack{
                    Circle()
                        .stroke(lineWidth: CGFloat(outlineWidth) )
                        .foregroundColor(Color.black)
                    //main circle
                    Circle()
                        .foregroundColor(Color.white)
                }
            }
        }
    }
    
    // a struct for an entire guess row
    //column is the circle in the guess and the row is what guess the user is on
    struct CircleGuessRow: View {
        var row: Int
        @ObservedObject var vmLocal: ViewModel
        var body: some View {
            HStack{
                
                //for each for each circle in the guess
                ForEach(0..<CIRCLE_GUESS_COUNT, id:\.self){ column in
                    //this confusing mess is the computed variable of what we select from the ontapgesture from below
                    //it is watching the vm version of the userguesses and when the value is set to a certain color it updates automatically
                    if (vmLocal.userGuesses[row].isSelectable == true){
                        CircleGuessView(CircleId: vmLocal.userGuesses[row].guessItem[column], outlineWidth: 12)
                            .onTapGesture {
                                //print("VIEW: setting circle number \(column) in row \(row)")
                                vmLocal.setGuessColor(row: row, col: column)
                            }
                    }
                    else{
                        CircleGuessView(CircleId: vmLocal.userGuesses[row].guessItem[column], outlineWidth: 6)
                       
                    }
                }
            }
        }
    }
    
    //struct for the feedback bead
    struct feedBack: View {
        var row: Int
        @ObservedObject var vm: ViewModel
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(Color.black.gradient)
                    .scaledToFit()
                VStack{
                    HStack{
                        ForEach (0..<CIRCLE_GUESS_COUNT/2, id:\.self) {circle in
                            ZStack{
                                Circle()
                                    .foregroundColor(getFeedBackColor(feadbackColor: vm.userGuesses[row].feedbackBeads[circle]))
                                    .scaledToFit()
//
                            }
                        }
                    }
                    .scaledToFit()
                        
                    HStack{
                            ForEach (0..<CIRCLE_GUESS_COUNT/2, id:\.self) {circle in
                                ZStack{
                                    Circle()
                                        .foregroundColor(getFeedBackColor(feadbackColor: vm.userGuesses[row].feedbackBeads[circle + 2 ]))
                                        .scaledToFit()
//
                                }
                            }
                        }
                    .scaledToFit()
                    
                }
            }
        }
    }
}

//gets color of the bead 
func getFeedBackColor (feadbackColor: feedbackBead?) -> Color {
    if let feedback = feadbackColor{
        switch feedback {
        case .red:
            return Color.red
        case .white:
            return Color.white
        case .clear:
            return Color.clear
        }
    }
    return Color.clear
}














#Preview {
    ContentView()
}
