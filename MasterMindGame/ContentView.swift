//File: ContentView
//Jackson Holt
//CS 3164, Winter 2024
//
//  ContentView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 1/16/24.
// this is the view file for what the master mind game will look like
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //array of colors for the circles
        let colorArray = [Color.red, Color.green, Color.blue, Color.yellow, Color.purple, Color.orange]
        HStack {
            //foreach for all the circles
            ForEach(0..<6, content: {index in
                ZStack{
                    //background circle
                    Circle()
                        .stroke(lineWidth: 5 )
                        .foregroundColor(Color.black)
                   //main circle
                    Circle()
                        .foregroundColor(colorArray[index])
                        
                }
                
            })
        }
        .padding()
        
    }
       
}
                    
                    
                    
                    
                    
                    
#Preview {
    ContentView()
}
