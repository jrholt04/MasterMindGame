//
//  Model.swift
//  MasterMindGame
//
//    MODEL
//
//  Created by Jackson Holt on 1/21/24.
//

import Foundation

struct Model {
    
    //our variables for the model
    // this is an array that represents the selection colors at the bottom of the screen
    var circleOptions: Array<CircleOption>
    var currentCircle: Int? //this is an optional and the selected color in the selection row
    var currentRowNumber = MAX_ATTEMPTS - 1
    //array of the secret code
    var secretCode: Array<SecretBead>
    
    //array of all user guesses
    var userGuesses: Array<Guess>
    
    //initiazlizes all of the circles in the array
    init (numberOfCircleOption: Int){
        circleOptions = Array<CircleOption>()
        secretCode = Array<SecretBead>()
        for circleIndex in 0..<numberOfCircleOption {
            circleOptions.append(CircleOption(id: circleIndex, isSelected: false))
        }
        
        //initalize the array of all the users guesses
        userGuesses = Array<Guess>()
        for i in 0..<MAX_ATTEMPTS{
            userGuesses.append(Guess(id: i, isFullGuess: false, isSelectable: false))
        }
        userGuesses[currentRowNumber].isSelectable = true
        
        //init the secret code array
        //the randomizer is from this link https://codewithchris.com/swift-random-number/
        for i in 0..<CIRCLE_GUESS_COUNT{
            secretCode.append(SecretBead(id: i, colorOfBead: Int(arc4random_uniform(6))) )
        }
//        for i in 0..<CIRCLE_GUESS_COUNT{
//            print("the \(i)th bead in the guess is color \(secretCode[i].colorOfBead)th color in the array of valid colors")
//        }
        if (TEST_MODE == true){
            print("MODEL: we are in test mode ")
        }
        
    }
    
    //mutator func that on click changes the bool var of the circle to true and reverts the previsous selection to false 
    mutating func chooseCircle(circleNumber: Int){
        if let oldCircle = currentCircle{
            circleOptions[oldCircle].isSelected = false
        }
        circleOptions[circleNumber].isSelected = true
        currentCircle = circleNumber
        //print("MODEL: model chose letter number \(circleNumber)")
    }
    
    //this is a function that sets the selected row to the row var in the model
    mutating func chooseRow(rowNumber: Int){
        //print("VIEWMODEL: choose row number \(rowNumber)")
    }
    
    //set a color in the user guess
    //set the current row and current selected cirlce to a specific color
    mutating func setGuessColor(row: Int, col: Int){
        //print("MODEL: setting color for \(col) in row \(row)")
        if (userGuesses[row].guessItem[col] == currentCircle){
            userGuesses[row].guessItem[col] = nil
        }
        else{
            userGuesses[row].guessItem[col] = currentCircle
        }
        checkForFullGuess(row: row)
    }
    
    //this function checks to see if the current row is full or not
    mutating func checkForFullGuess(row: Int){
        for i in 0..<CIRCLE_GUESS_COUNT{
            if (userGuesses[row].guessItem[i] != nil){
                userGuesses[row].isFullGuess = true
            }
            else {
                userGuesses[row].isFullGuess = false
                //print("MODEL: this guess is not full")
                break
                
            }
        }
    }
    
    //this takes the function to the next row if it is a full guess
    mutating func nextRow(){
        if (userGuesses[currentRowNumber].isFullGuess == true && currentRowNumber == 0){
            userGuesses[currentRowNumber].isSelectable = false
        }
        else {
            userGuesses[currentRowNumber - 1].isSelectable = true
            userGuesses[currentRowNumber].isSelectable = false
            currentRowNumber = currentRowNumber - 1
        }
        if(TEST_MODE == true){
            setSecretCodeT()
            print("MODEL: the test code is \(secretCode[0]), \(secretCode[1]), \(secretCode[2]), \(secretCode[3])")
        }
    }
    
    //set testmodeguees
    //   this function sets the guess bead to the first user guess if test mode is enabled
    mutating func setSecretCodeT() {
        for i in 0..<CIRCLE_GUESS_COUNT {
            if let tempColor = userGuesses[ MAX_ATTEMPTS - 1 ].guessItem[i] {
                secretCode[i].colorOfBead = tempColor
            }
        }
    }
}

//this is one bead in the selection row in the bottom
struct CircleOption: Identifiable {
    // id is the index number in the array of colors
    var id : Int
    
    // is this a selected circle option
    var isSelected: Bool
}

//this struct represnts one row of the guesses 
struct Guess: Identifiable {
    var id: Int
    var isFullGuess: Bool
    var isSelectable: Bool
    
    //an array of optionals to hold the user guess
    var guessItem: [Int?] = Array(repeating: nil, count: CIRCLE_GUESS_COUNT)
}

//this struct uses a random number generator to store the value of the color in the corresponding array of colors
struct SecretBead: Identifiable {
    var id: Int
    var colorOfBead: Int
}
