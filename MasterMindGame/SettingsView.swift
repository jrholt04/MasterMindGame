//
//  SettingsView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm : ViewModel
    var colorPallet : Bool
    
    var body: some View {
        VStack{
            HStack{
                VStack{
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
            
            ZStack{
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .foregroundColor(vm.musicOn ? .green : .red)
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .stroke(lineWidth: LINE_WIDTH)
                    .foregroundColor(Color.black)
                Text("Music")
                    .bold()
                    .font(.system(size: CGFloat(TEXTSIZE)))
                    .padding()
                    .foregroundColor(.black)
            }
            .scaledToFit()
            .padding()
            .onTapGesture{
                vm.toggleMusic()
            }
            
        }
    }
}

