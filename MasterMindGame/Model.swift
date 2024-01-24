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
    var circleOptions: Array<CircleOption>
    var currentCircle: Int? //this is an optional
    
    //array of all user guesses
    var userGuesses: Array<Guess>
    
    //initiazlizes all of the circles in the array
    init (numberOfCircleOption: Int){
        circleOptions = Array<CircleOption>()
        for circleIndex in 0..<numberOfCircleOption {
            circleOptions.append(CircleOption(id: circleIndex, isSelected: false))
        }
        
        //initalize the array of all the users guesses
        userGuesses = Array<Guess>()
        for i in 0..<MAX_ATTEMPTS{
            userGuesses.append(Guess(id: i))
        }
    }
    
    //mutator func that on click changes the bool var of the circle to true and reverts the previsous selection to false 
    mutating func chooseCircle(circleNumber: Int){
        if let oldCircle = currentCircle{
            circleOptions[oldCircle].isSelected = false
        }
        circleOptions[circleNumber].isSelected = true
        currentCircle = circleNumber
        print("MODEL: model chose letter number \(circleNumber)")
    }
    
    
}


struct CircleOption: Identifiable {
    // id is the index number in the array of colors
    var id : Int
    
    // is this a selected circle option
    var isSelected: Bool
    
    
}

struct Guess: Identifiable {
    //
    var id: Int
    
    //an array of optionals to hold the user guess
    var guessItem: [Int?] = Array(repeating: nil, count: CIRCLE_GUESS_COUNT)
    
}
