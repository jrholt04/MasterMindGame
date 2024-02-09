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
    
    //get all of the users guesses
    var userGuesses: Array<Guess> {
       return m.userGuesses
    }
    
    //choose a row
    func chooseRow(rowNumber: Int){
        //print("VIEWMODEL: choose row number \(rowNumber)")
        m.chooseRow(rowNumber: rowNumber)
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
        //print("VIEW MODEL: set letter \(col) in row \(row)")
        m.setGuessColor(row: row, col: col)
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
}
