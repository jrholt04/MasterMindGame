//
//  StatsView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/5/24.
//

import SwiftUI

struct StatsView: View {
    
    var totalGames : Int
    var gamesWon : Int
    var winPercent: Double
    @ObservedObject var vm: ViewModel
    
    init(totalGames: Int, gamesWon: Int, vm: ViewModel) {
        self.totalGames = totalGames
        self.gamesWon = gamesWon
        if (gamesWon == 0){
            winPercent = 0
        }
        else {
            winPercent = (Double(gamesWon)/Double(totalGames))*100
        }
        self.vm = vm
    }
    
    
    var body: some View {
        HStack{
            ZStack{
                
                VStack{
                    Text("         \(totalGames)")
                    Text("         Games Played")
                }
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .stroke()
                    .fill(.black)
                    .frame(width: 200, height: 50)
                    .offset(x: 20)
            }
            ZStack{
                
                VStack{
                    Text("         \(Int(winPercent))%")
                    Text("           Win Percentage")
                }
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .stroke()
                    .fill(.black)
                    .frame(width: 200, height: 50)
                    .offset(x: 20)
            }
        }
        .bold()
        .foregroundColor(.black)
        .font(.system(size: CGFloat(TEXTSIZE / 2)))
            VStack{
                Text("")
                ForEach(0..<MAX_ATTEMPTS, id:\.self) {i in
                    Text("row \(i + 1): \(vm.stats[9 - i])")
                }
            .bold()
            .foregroundColor(.black)
            .font(.system(size: CGFloat(TEXTSIZE / 2)))
        }
    }
}







