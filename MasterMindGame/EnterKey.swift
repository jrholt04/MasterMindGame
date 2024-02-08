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
        RoundedRectangle(cornerRadius: 16.0)
            .fill(Color.black.gradient)
            .scaledToFit()
        RoundedRectangle(cornerRadius: 16.0)
            .stroke(lineWidth: 4.0)
            .foregroundColor(state == .enabled ? Color.red : .clear)
            .scaledToFit()
        Text("Enter")
            .bold()
            .font(.system(size: 20))
    }
    .foregroundColor(state == .enabled ? Color.white : .clear)
}
