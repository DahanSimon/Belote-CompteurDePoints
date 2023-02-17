//
//  Game.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import Foundation
import SwiftUI

class Game: Identifiable, ObservableObject {
    
    var id = UUID()
    @Published var teams: [Team]
    @Published var rounds: [Round] = []
    
    var scores: [Team: Int] {
        var tempScores: [Team: Int] = [:]
        
        for team in teams {
            tempScores[team] = 0
        }
        for round in rounds {
            for team in teams {
                tempScores[team]! += round.scores[team] ?? 0
            }
        }
        return tempScores
    }
    
    init(teams: [Team], rounds: [Round] = []) {
        self.teams = teams
        self.rounds = rounds
    }
    
    func resetGame() {
        let teams = [Team(name: "Nous"), Team(name: "Eux")]
        id = UUID()
        self.teams = teams
        rounds = []
    }
    
}
