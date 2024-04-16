//
//  Model.swift
//  MasterMindGame
//
//    MODEL
//
//  Created by Jackson Holt on 1/21/24.
//
// this is the sources for the userDefualts
//https://www.youtube.com/watch?v=OLyGYcSw9Bs
//https://www.youtube.com/watch?v=vDbFH9D6BSA

import Foundation

//current state of the game
enum GameState {
    case playing
    case won
    case lost
}

struct Model {
    
    //var for colorblind mode
    var colorBlind: Bool = false
    //is the game over?
    // did the user win
    var gameState: GameState = .playing
    
    //is music playing or not 
    var musicOn: Bool = true
    
    //this decides which color pannel is selected
    var colorPallet: Bool = true
    
    //saved data
    var stats : [Any] = UserDefaults.standard.array(forKey: "stats") ?? Array(repeating: 0, count: MAX_ATTEMPTS)

    // this is an array that represents the selection colors at the bottom of the screen
    var circleOptions: Array<CircleOption>
    
    var currentCircle: Int? //this is an optional and the selected color in the selection row
    
    var currentRowNumber = MAX_ATTEMPTS - 1
    //array of the secret code
    var secretCode: Array<SecretBead>
    
    //array of all user guesses
    var userGuesses: Array<Guess>
    
    //initiazlizes all of the circles in the array
    init (numberOfCircleOption: Int){
        playSound(sound: "background", type: "mp3")
        circleOptions = Array<CircleOption>()
        secretCode = Array<SecretBead>()
        for circleIndex in 0..<numberOfCircleOption {
            circleOptions.append(CircleOption(id: circleIndex, isSelected: false))
        }
        
        //initalize the array of all the users guesses
        userGuesses = Array<Guess>()
        for i in 0..<MAX_ATTEMPTS{
            userGuesses.append(Guess(id: i, isFullGuess: false, isSelectable: false))
        }
        userGuesses[currentRowNumber].isSelectable = true
        
        //init the secret code array
        //the randomizer is from this link https://codewithchris.com/swift-random-number/
        for i in 0..<CIRCLE_GUESS_COUNT{
            secretCode.append(SecretBead(id: i, colorOfBead: Int(arc4random_uniform(6)), isChecked: false) )
        }
        print("MODEL The Regular Secret code is ")
        for i in 0..<CIRCLE_GUESS_COUNT{
            print("the \(i)th bead in the guess is color \(secretCode[i].colorOfBead)th color in the array of valid colors")
            print()
        }
        if (TEST_MODE == true){
            print("MODEL: we are in test mode ")
            print()
        }
        
    }
    
    //mutator func that on click changes the bool var of the circle to true and reverts the previsous selection to false 
    mutating func chooseCircle(circleNumber: Int){
        if let oldCircle = currentCircle{
            circleOptions[oldCircle].isSelected = false
        }
        circleOptions[circleNumber].isSelected = true
        currentCircle = circleNumber
    }
    
    //set a color in the user guess
    //set the current row and current selected cirlce to a specific color
    mutating func setGuessColor(row: Int, col: Int){
        if (userGuesses[row].guessItem[col] == currentCircle){
            userGuesses[row].guessItem[col] = nil
        }
        else{
            userGuesses[row].guessItem[col] = currentCircle
        }
        checkForFullGuess(row: row)
    }
    
    //this function checks to see if the current row is full or not
    mutating func checkForFullGuess(row: Int){
        for i in 0..<CIRCLE_GUESS_COUNT{
            if (userGuesses[row].guessItem[i] != nil){
                userGuesses[row].isFullGuess = true
            }
            else {
                userGuesses[row].isFullGuess = false
                break
                
            }
        }
    }
    
    //this takes the function to the next row if it is a full guess
    mutating func nextRow(){
        checkGuess()
        //print("this is the value of stat[0] \(stats[0])")
        //this is the base case for the last row
        if (userGuesses[currentRowNumber].isFullGuess == true && currentRowNumber == 0){
            userGuesses[currentRowNumber].isSelectable = false
            if (userGuesses[currentRowNumber].isRight()){
                //we Have a winner
                gameState = .won
                print ("MODEL the user has won ")
                userGuesses[currentRowNumber].isSelectable = false
                playSound(sound: "chime", type: "mp3")
            }
            else {
                gameState = .lost
                print ("MODEL you lost Bozo ")
                userGuesses[currentRowNumber].isSelectable = false
            }
        }
        //going over a regular row
        else {
            if (userGuesses[currentRowNumber].isRight()){
                gameState = .won
                userGuesses[currentRowNumber].isSelectable = false
                playSound(sound: "chime", type: "mp3")
                print ("MODEL the user has won")
            }
            else{
                userGuesses[currentRowNumber - 1].isSelectable = true
                userGuesses[currentRowNumber].isSelectable = false
                currentRowNumber = currentRowNumber - 1
                
            }
        }
        if(TEST_MODE == true){
            setSecretCodeT()
            print("MODEL the TESTING secret code is: ")
            print("MODEL: the test code is \(secretCode[0]), \(secretCode[1]), \(secretCode[2]), \(secretCode[3])")
        }
        
        updateStats()

    }
    
    //set testmodeguees
    //   this function sets the guess bead to the first user guess if test mode is enabled
    mutating func setSecretCodeT() {
        for i in 0..<CIRCLE_GUESS_COUNT {
            if let tempColor = userGuesses[ MAX_ATTEMPTS - 1 ].guessItem[i] {
                secretCode[i].colorOfBead = tempColor
            }
        }
    }
    
    //function to check if the guess the user has put in is correct and give fedbackbeads
    mutating func checkGuess(){
       var feedBackBeadI = 0
        for i in 0..<CIRCLE_GUESS_COUNT{
            if (userGuesses[currentRowNumber].guessItem[i] == secretCode[i].colorOfBead){
                userGuesses[currentRowNumber].isChecked[i] = true
                userGuesses[currentRowNumber].feedbackBeads[feedBackBeadI] = .red
                secretCode[i].isChecked = true
                feedBackBeadI = feedBackBeadI + 1
            }
        }
       
        //check for white beads
        for i in 0..<CIRCLE_GUESS_COUNT{
            for j in 0..<CIRCLE_GUESS_COUNT{
                if ((!userGuesses[currentRowNumber].isChecked[i])&&(!secretCode[j].isChecked)&&(secretCode[j].colorOfBead == userGuesses[currentRowNumber].guessItem[i] )){
                    userGuesses[currentRowNumber].isChecked[i] = true
                    userGuesses[currentRowNumber].feedbackBeads[feedBackBeadI] = .white
                    secretCode[j].isChecked = true
                    feedBackBeadI = feedBackBeadI + 1
                }
            }
        }
        
        
        print("MODEL: the feedback is \(userGuesses[currentRowNumber].feedbackBeads)")
                
        for i in 0..<CIRCLE_GUESS_COUNT{
            secretCode[i].isChecked = false
        }
    }
    
    //updates the stats if there was a game won
    mutating func updateStats(){
        if (gameState == .won){
            if let statsArray = UserDefaults.standard.array(forKey: "stats") as? [Int] {
                var stats = statsArray
                stats[currentRowNumber] += 1
                UserDefaults.standard.set(stats, forKey: "stats")
            }
        }
    }
    
    //this resets the user stats that are saved as user defaults 
    mutating func resetStat(){
        for i in 0..<MAX_ATTEMPTS{
            if let statsArray = UserDefaults.standard.array(forKey: "stats") as? [Int] {
                var stats = statsArray
                stats[i] = 0
                UserDefaults.standard.set(stats, forKey: "stats")
            }
        }
    }
    
    //toggle colorblind mode on and off
    mutating func toggleColorBlind(){
        if colorBlind {
            colorBlind = false
        }
        else {
            colorBlind = true
        }
    }
    
    //turns music on and off
    mutating func toggleMusic() {
        if musicOn {
            musicOn = false
            playSound(sound: "", type: "mp3")
        }
        else {
            musicOn = true
            playSound(sound: "background", type: "mp3")
        }
    }
    
    //changes from original color pallet to color pallet 2
    mutating func toggleColorPallet(){
        if colorPallet{
            colorPallet = false
        }
        else {
            colorPallet = true
        }
    }
    
    //reset function that leazes out things that I do not want re-intialed everytime
    mutating func resetGame() {
        currentRowNumber = MAX_ATTEMPTS - 1
        
        if musicOn {
            playSound(sound: "background", type: "mp3")
        }
        circleOptions = Array<CircleOption>()
        secretCode = Array<SecretBead>()
        for circleIndex in 0..<NUMBER_OF_CIRCLE {
            circleOptions.append(CircleOption(id: circleIndex, isSelected: false))
        }
        
        //initalize the array of all the users guesses
        userGuesses = Array<Guess>()
        for i in 0..<MAX_ATTEMPTS{
            userGuesses.append(Guess(id: i, isFullGuess: false, isSelectable: false))
        }
        userGuesses[currentRowNumber].isSelectable = true
        
        //init the secret code array
        //the randomizer is from this link https://codewithchris.com/swift-random-number/
        for i in 0..<CIRCLE_GUESS_COUNT{
            secretCode.append(SecretBead(id: i, colorOfBead: Int(arc4random_uniform(6)), isChecked: false) )
        }
        print("MODEL The Regular Secret code is ")
        for i in 0..<CIRCLE_GUESS_COUNT{
            print("the \(i)th bead in the guess is color \(secretCode[i].colorOfBead)th color in the array of valid colors")
            print()
        }
        if (TEST_MODE == true){
            print("MODEL: we are in test mode ")
            print()
        }
        gameState = .playing 
        currentRowNumber = MAX_ATTEMPTS - 1
    }
    
    
    
}

//this is one bead in the selection row in the bottom
struct CircleOption: Identifiable {
    // id is the index number in the array of colors
    var id : Int
    
    // is this a selected circle option
    var isSelected: Bool
}

//this struct represnts one row of the guesses 
struct Guess: Identifiable {
    var id: Int
    var isFullGuess: Bool
    var isSelectable: Bool
    //feedback bead array
    var feedbackBeads: [feedbackBead?] = Array(repeating: .clear , count: CIRCLE_GUESS_COUNT)
    
    //an array of optionals to hold the user guess
    var guessItem: [Int?] = Array(repeating: nil, count: CIRCLE_GUESS_COUNT)
    //parrellel array to mark if this index had been checked or not
    var isChecked: [Bool] = Array(repeating: false, count: CIRCLE_GUESS_COUNT)
    
    //did the user win ie is the guess right
    func isRight() -> Bool{
        for i in 0..<CIRCLE_GUESS_COUNT {
            if feedbackBeads[i] != .red {
                return false
            }
            
        }
        return true
    }
    
}

//this struct uses a random number generator to store the value of the color in the corresponding array of colors
struct SecretBead: Identifiable {
    var id: Int
    var colorOfBead: Int
    var isChecked: Bool
}

//enum for the state of the feedback beads 
enum feedbackBead {
    case red
    case white
    case clear
}
