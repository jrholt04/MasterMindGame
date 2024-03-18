//
//  PlaySound.swift
//  MasterMindGame
//
//  Created by Jackson Holt on 3/18/24.
//
// this plays the audio that is selected by the function call
// source: https://www.youtube.com/watch?v=6l5nJgrXTfc&t=575s
// this let me loop the entire background sound infintly
// source:https://stackoverflow.com/questions/59031264/play-a-sound-file-on-repeat-in-swift
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("ERROR: could not find and play the sound file!")
        }
    }
    if (sound == "background"){
        audioPlayer?.numberOfLoops = -1
    }
}

