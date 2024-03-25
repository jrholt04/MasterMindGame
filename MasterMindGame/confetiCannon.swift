//
//  confetiCannon.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 3/25/24.
//
// this effects library documentation
//   https://getstream.github.io/effects-library/tutorials/effectslibrary/getting-started/
// and the git repo
//   https://github.com/GetStream/effects-library/blob/main/README.md

import SwiftUI
import EffectsLibrary

struct confetiCannon: View {
    var body: some View {
        ConfettiView(
            config: ConfettiConfig(
                content: [
                    .emoji("😁", 1.0),
                    .emoji("🥳", 1.0),
                    .emoji("👍", 1.0),
                    .emoji("🧨", 1.0)
                ]
            )
        )
    }
}

struct confettiLost: View {
    var body: some View{
        ConfettiView(
            config: ConfettiConfig(
                content: [
                    .emoji("👹", 1.0),
                    .emoji("💩", 1.0),
                    .emoji("👎", 1.0),
                    .emoji("💥", 1.0)
                ]
            )
        )
    }
}
