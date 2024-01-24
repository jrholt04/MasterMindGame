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
    
    
    //this allows the view model to present the circleOptions array to the view
    var circleOptions: Array<CircleOption>{
        return m.circleOptions
    }
    
    //this is the choose cirlce function that passes the onclick function to the model
    func chooseCircle(circleNumber: Int){
        m.chooseCircle(circleNumber: circleNumber)
        print("VIEW MODEL: choose circle number \(circleNumber)")
    }
    
}
