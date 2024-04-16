//
//  StatsView.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 4/5/24.
//
//   This is the stats view that allows the user to see their percent won, games played and win distribution
//
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
       // this calcuates the 
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
            //this displays the total games
            ZStack{
                
                VStack{
                    Text("         \(totalGames)")
                    Text("         Games Played")
                }
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .stroke()
                    .fill(.black)
                    .frame(width: CGFloat(statsWIDTH), height: CGFloat(statsHEIGHT))
                    .offset(x: CGFloat(statsOFFSET))
            }
            // this displays the win percentage
            ZStack{
                
                VStack{
                    Text("         \(Int(winPercent))%")
                    Text("           Win Percentage")
                }
                RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
                    .stroke()
                    .fill(.black)
                    .frame(width: CGFloat(statsWIDTH), height: CGFloat(statsHEIGHT))
                    .offset(x: CGFloat(statsOFFSET))
            }
        }
        .bold()
        .foregroundColor(.black)
        .font(.system(size: CGFloat(TEXTSIZE / 2)))
            VStack{
                Text("")
                ForEach(0..<MAX_ATTEMPTS, id:\.self) {i in
                    Text("row \(i + 1): \(vm.stats[(MAX_ATTEMPTS - 1) - i])")
                }
            .bold()
            .foregroundColor(.black)
            .font(.system(size: CGFloat(TEXTSIZE / 2)))
        }
    }
}







