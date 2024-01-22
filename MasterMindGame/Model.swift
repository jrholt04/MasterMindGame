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
    
    var circleOptions: Array<CircleOption>
    var currentCircle: Int? //this is an optional
    
    //initiazlizes all of the circles in the array
    init (numberOfCircleOption: Int){
        circleOptions = Array<CircleOption>()
        for circleIndex in 0..<numberOfCircleOption {
            circleOptions.append(CircleOption(id: circleIndex, isSelected: false))
        }
    }
    
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
