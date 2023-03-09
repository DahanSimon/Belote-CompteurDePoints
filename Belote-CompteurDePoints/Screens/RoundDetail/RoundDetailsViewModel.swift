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
    @Published var currentRound: Round
    var game: Game
    
    
    @Published var showColorPicker = false
    
    
    init(game: Game, round: Round) {
        self.teams = game.teams
        self.game = game
        self.currentRound = round
    }
    
    var penalties: Int {
        return 160 + (currentRound.contree ? 160 : 0) + (currentRound.contree && currentRound.surContree ? 160 : 0)
    }
    
    var result: String {
        let teamNames = teams.map({ team in
            return team.name
        })
        
        guard let score = Int(currentRound.pointsFait) as? Int , let annonce = Int(currentRound.annonce) as? Int else {
            return "Une erreur c'est produite"
        }
        
        if score < annonce {
            return "L'équipe \(teamNames[currentRound.announcingTeamIndex]) a perdu"
        }
        
        return "L'équipe \(teamNames[currentRound.announcingTeamIndex]) a gagné et l'équipe \(teamNames[currentRound.beloteBeneficiary]) benefice de 20 points supplementaire"
    }
    
    func addRound(callback: @escaping ((Bool) -> Void)) {
        
        guard let team1 = game.teams.first, let team2 = game.teams.last else {
            callback(false)
            return
        }
        
        let scores = getScores()!
        currentRound.scores = scores
        team1.score += scores[team1]!
        team2.score += scores[team2]!
        
        if let index = game.rounds.firstIndex(where: { $0.id == currentRound.id }) {
            game.rounds[index] = currentRound
            callback(true)
            return
        }
        
        game.rounds.append(currentRound)
        callback(true)
    }
    
    func getScores() -> [Team: Int]? {
        var scores: [Team: Int] = [:]
        let opponentTeam: Team = teams.first { $0.id != teams[currentRound.announcingTeamIndex].id }!

        guard let pointsFait = Int(currentRound.pointsFait), let annonce = Int(currentRound.annonce) else {
            return nil
        }
        
        if pointsFait < annonce {
            scores[game.teams[currentRound.announcingTeamIndex]] = 0
            scores[opponentTeam] = annonce + penalties
        } else if pointsFait > annonce {
            let pointsFaitOpponent = 162 - pointsFait
            scores[game.teams[currentRound.announcingTeamIndex]] = pointsFait + annonce
            scores[opponentTeam] = 10 * Int(round(Double((pointsFaitOpponent + 5) / 10)))
        }
        return scores
    }
}
