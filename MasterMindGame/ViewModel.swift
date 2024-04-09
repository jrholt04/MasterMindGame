//
//  ViewModel.swift
//  MasterMindGame
//
//   VIEW MODEL
//
//  Created by Jackson Holt on 1/21/24.
//

import Foundation


class ViewModel: ObservableObject  {
    
    //makes the model viewable to the view model
    @Published var m = Model(numberOfCircleOption: NUMBER_OF_CIRCLE)
    
    //pass through for music var
    var musicOn : Bool {
        m.musicOn
    }
    
    //pass throughg for music toggle function 
    func toggleMusic() {
        m.toggleMusic()
    }
    
    func restartGame() {
        m = Model(numberOfCircleOption: NUMBER_OF_CIRCLE)
    }
    
    //var for the secret code
    var secretCode: Array<SecretBead>{
        return m.secretCode
    }
    
    //get all of the users guesses
    var userGuesses: Array<Guess> {
       return m.userGuesses
    }
    
    //this allows the view model to present the circleOptions array to the view
    var circleOptions: Array<CircleOption>{
        return m.circleOptions
    }
    
    //this is the choose cirlce function that passes the onclick function to the model
    func chooseCircle(circleNumber: Int){
        m.chooseCircle(circleNumber: circleNumber)
        //print("VIEW MODEL: choose circle number \(circleNumber)")
    }
    
    //this is the function to set the color of the selected cirlce to the choosen color
    func setGuessColor(row: Int, col: Int){
        if (gameState == .playing){
            //print("VIEW MODEL: set letter \(col) in row \(row)")
            m.setGuessColor(row: row, col: col)
        }
        else {
            print("VIEW MODEL game is over ")
        }
    }
    
    //pass through var for current row 
    var currentRow: Int {
        return m.currentRowNumber
    }
    
    //pass throuhg for the check for the full guess row
    func checkForFullGuess (row: Int){
        return m.checkForFullGuess(row: row)
    }
    
    //pass through for the next row funciton
    func nextRow (){
        return m.nextRow()
    }
    
    //do we have a winner
    var winner: Bool{
        return m.gameState == .won
    }
    
    //get the game state
    var gameState: GameState{
       return  m.gameState
    }
    
    var stats: [Int] {
        if let statsArray = UserDefaults.standard.array(forKey: "stats") as? [Int] {
            return statsArray
        }
        return Array(repeating: 0, count: CIRCLE_GUESS_COUNT)
    }
    
    func resetStats(){
        m.resetStat()
    }
    
}
