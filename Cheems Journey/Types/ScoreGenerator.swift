//
//  ScoreGenerator.swift
//  Cheems Journey
//
//  Created by Donnie Tran on 9/2/23.
//

import Foundation

class scoreGenerator{
    
    static let sharedInstance = scoreGenerator()
    private init() {}
    
    static let keyHighScore = "keyHighScore"
    static let keyScore = "keyScore"
    
    func setScore (_ score: Int){
        UserDefaults.standard.set(score, forKey: scoreGenerator.keyScore)
    }
    func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: scoreGenerator.keyScore)
    }
    func setHighScore (_ highscore: Int){
        UserDefaults.standard.set(highscore, forKey: scoreGenerator.keyHighScore)
    }
    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: scoreGenerator.keyHighScore)
    }
}
