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
        HStack {
            ForEach(0..<4, content: {index in
                ZStack{
                    Circle()
                        .foregroundColor(.red)
                    Circle()
                        .stroke(lineWidth: 3 )
                        .colorInvert()
                }
            })
        }
        
    }
                    
                    
                    
                    
                    
                    
#Preview {
    ContentView()
}
