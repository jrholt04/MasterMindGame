//
//  SettingsView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/8/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm : ViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .stroke(lineWidth: LINE_WIDTH)
                            .foregroundColor(Color.black)
                        HStack{
                            ForEach(0..<NUMBER_OF_CIRCLE, id:\.self) {thisCircle in
                                ZStack{
                                    //background circle
                                    Circle()
                                        .stroke(lineWidth: CGFloat(OUTLINESIZE))
                                        .foregroundColor(Color.black)
                                    //main circle
                                    Circle()
                                        .foregroundColor(colorArray2[thisCircle])
                                    
                                    
                                }
                                
                            }
                            .padding()
                        }
                        
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                            .stroke(lineWidth: LINE_WIDTH)
                            .foregroundColor(Color.black)
                        HStack{
                            ForEach(0..<NUMBER_OF_CIRCLE, id:\.self) {thisCircle in
                                ZStack{
                                    //background circle
                                    Circle()
                                        .stroke(lineWidth: CGFloat(OUTLINESIZE))
                                        .foregroundColor(Color.black)
                                    //main circle
                                    Circle()
                                        .foregroundColor(colorArray[thisCircle])
                                    
                                    
                                }
                                
                            }
                            .padding()
                        }
                       
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

#Preview {
    SettingsView(vm : ViewModel())
}
