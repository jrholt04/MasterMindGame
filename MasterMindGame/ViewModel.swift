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
    
    @Published var m = Model(numberOfCircleOption: NUMBER_OF_CIRCLE)
    
    
    var circleOptions: Array<CircleOption>{
        return m.circleOptions
    }
    
    func chooseCircle(circleNumber: Int){
        m.chooseCircle(circleNumber: circleNumber)
        print("VIEW MODEL: choose circle number \(circleNumber)")
    }
    
}
