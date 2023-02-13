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
    
    init(teams: [Team], rounds: [Round] = []) {
        self.teams = teams
        self.rounds = rounds
    }
    
    func resetGame() {
        id = UUID()
        teams = []
        rounds = []
    }
}
