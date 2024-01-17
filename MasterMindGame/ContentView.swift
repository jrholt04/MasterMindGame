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
        let colorArray = [Color.red, Color.green, Color.blue, Color.yellow, Color.purple, Color.orange]
        HStack {
            ForEach(0..<6, content: {index in
                ZStack{
                    Circle()
                        .stroke(lineWidth: 10 )
                        .colorInvert()
                    Circle()
                        .foregroundColor(colorArray[index])
                        
                }
            })
        }
        
    }
}
                    
                    
                    
                    
                    
                    
#Preview {
    ContentView()
}
