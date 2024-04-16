//
//  SettingsView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//
// This is the settins view where we can modify the game
//      music, color pallet, and colorblind mode
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm : ViewModel
    var colorPallet : Bool
    
    var body: some View {
        VStack{
            HStack{
                
                VStack{
                    //this is the button to turn music on and off
                    Button(action: {
                        vm.toggleMusic()
                    }) {
                        Text("Music")
                            .foregroundColor(.black)
                            .padding()
                            .background(vm.musicOn ? .green : .red)
                            .cornerRadius(10)
                    }
                    //button for color blind mode
                    Button(action: {
                        vm.toggleColorBlind()
                    }) {
                        Text("Color Blind Mode")
                            .foregroundColor(.black)
                            .padding()
                            .background(vm.colorBlind ? .green : .red)
                            .cornerRadius(10)
                    }
                    .scaledToFill()
                    
                    //this is the color selection pallets
                    ZStack{
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .stroke(lineWidth: colorPallet ?  CGFloat(SETTING_OUTLINE) : CGFloat((SETTING_OUTLINE * 2)))
                            .foregroundColor(Color.black)
                        HStack{
                            ForEach(0..<NUMBER_OF_CIRCLE, id:\.self) {thisCircle in
                                ZStack{
                                    //background circle
                                    Circle()
                                        .stroke(lineWidth: SETTING_OUTLINE)
                                        .foregroundColor(Color.black)
                                    //main circle
                                    Circle()
                                        .foregroundColor(colorArray2[thisCircle])
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                    .onTapGesture {
                        vm.toggleColorPallet()
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .stroke(lineWidth: colorPallet  ?  CGFloat((SETTING_OUTLINE * 2)) : CGFloat(SETTING_OUTLINE))
                            .foregroundColor(Color.black)
                        HStack{
                            ForEach(0..<NUMBER_OF_CIRCLE, id:\.self) {thisCircle in
                                ZStack{
                                    //background circle
                                    Circle()
                                        .stroke(lineWidth: SETTING_OUTLINE)
                                        .foregroundColor(Color.black)
                                    //main circle
                                    Circle()
                                        .foregroundColor(colorArray[thisCircle])
                                }
                                
                            }
                            .padding()
                        }
                    }
                    .padding()
                    .onTapGesture {
                        vm.toggleColorPallet()
                    }
                   
                }
            }
            .padding()
        }
        .scaledToFit()
    }
}

