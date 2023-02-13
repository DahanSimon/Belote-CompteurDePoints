//
//  RoundDetailsViewModel.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 12/02/2023.
//

import Foundation

class RoundDetailsViewModel: ObservableObject {
    
    var teams: [Team]
    let colors = ["♠️", "♥️", "♦️", "♣️"]
    var scores: [Team: Int] = [:]
    var round: Round?
    var game: Game
    
    @Published var selectedTeam = 0
    @Published var selectedColor = 0
    @Published var annonce = ""
    @Published var belote = false
    @Published var beloteBeneficiary = 0
    @Published var contree = false
    @Published var surContree = false
    @Published var score = ""
    @Published var showColorPicker = false
    
    
    init(game: Game) {
        self.teams = game.teams
        self.game = game
    }
    
    var result: String {
        let teamNames = teams.map({ team in
            return team.name
        })
        
        guard let score = Int(score) as? Int , let annonce = Int(annonce) as? Int else {
            return "Une erreur c'est produite"
        }
        
        if score < annonce {
            return "L'équipe \(teamNames[selectedTeam]) a perdu"
        }
        
        return "L'équipe \(teamNames[selectedTeam]) a gagné et l'équipe \(teamNames[beloteBeneficiary]) benefice de 20 points supplementaire"
    }
    
    func addRound(callback: @escaping ((Bool) -> Void)) {
        guard let team1 = game.teams.first, let team2 = game.teams.last else {
            callback(false)
            return
        }
        
        let scores = [team1: 100, team2: 200]
        let round = Round(teams: game.teams, scores: scores)
        game.rounds.append(round)
        team1.score += scores[team1]!
        team2.score += scores[team2]!
        callback(true)
    }
    
}
