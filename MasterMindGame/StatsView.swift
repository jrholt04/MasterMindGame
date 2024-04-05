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
    var winPercent: Int
    @ObservedObject var vm: ViewModel
    
    init(totalGames: Int, gamesWon: Int, vm: ViewModel) {
        self.totalGames = totalGames
        self.gamesWon = gamesWon
        if (gamesWon == 0){
            winPercent = 0
        }
        else {
            winPercent = (totalGames/gamesWon)*10
        }
        self.vm = vm
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Text("\(totalGames)")
                Text("Games Played")
            }
            HStack{
                Text("\(winPercent)")
                Text("Win Percentage")
            }
        }
        ScrollView{
            Text("win breakdown")
            VStack{
                ForEach(0..<MAX_ATTEMPTS, id:\.self) {i in
                    Text("row \(i + 1): \(vm.stats[i])")
                }
            }
        }
    }
}







