//
//  EnterKey.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 2/7/24.
//

import SwiftUI

//all possible enter key states
enum EnterKeyStates{
    case enabled
    case disabled
}

// EnterKey
//     an enterkey for the keyboard
struct EnterKey: View {
    var state: EnterKeyStates
    var body: some View {
        return makeEnterKeyBody(state: state)
    }
}


func makeEnterKeyBody(state: EnterKeyStates) -> some View {
    return ZStack{
        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
            .fill(Color.black.gradient)
            .scaledToFit()
        RoundedRectangle(cornerRadius: CGFloat(CORNER_RADDUIS))
            .stroke(lineWidth: CGFloat(LINE_WIDTH))
            .foregroundColor(state == .enabled ? Color.red : .clear)
            .scaledToFit()
        Text("Enter")
            .bold()
            .font(.system(size: CGFloat(TEXTSIZE/2)))
    }
    .foregroundColor(state == .enabled ? Color.white : .clear)
}
