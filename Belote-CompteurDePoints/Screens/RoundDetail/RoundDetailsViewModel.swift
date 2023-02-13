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
    var newRound: Round?
    var game: Game
    
    @Published var announcingTeamIndex = 0
    @Published var selectedColor = 0
    @Published var annonce = ""
    @Published var belote = false
    @Published var beloteBeneficiary = 0
    @Published var contree = false
    @Published var surContree = false
    @Published var pointsFait = ""
    @Published var showColorPicker = false
    
    
    init(game: Game) {
        self.teams = game.teams
        self.game = game
    }
    
    var penalties: Int {
        return 160 + (contree ? 160 : 0) + (contree && surContree ? 160 : 0)
    }
    
    var result: String {
        let teamNames = teams.map({ team in
            return team.name
        })
        
        guard let score = Int(pointsFait) as? Int , let annonce = Int(annonce) as? Int else {
            return "Une erreur c'est produite"
        }
        
        if score < annonce {
            return "L'équipe \(teamNames[announcingTeamIndex]) a perdu"
        }
        
        return "L'équipe \(teamNames[announcingTeamIndex]) a gagné et l'équipe \(teamNames[beloteBeneficiary]) benefice de 20 points supplementaire"
    }
    
    func addRound(callback: @escaping ((Bool) -> Void)) {
        guard let team1 = game.teams.first, let team2 = game.teams.last else {
            callback(false)
            return
        }
        
        let scores = getScores()
        let round = Round(teams: game.teams, scores: scores!)
        game.rounds.append(round)
        game.scores[team1]! += scores![team1]!
        game.scores[team2]! += scores![team2]!
        callback(true)
    }
    
    func getScores() -> [Team: Int]? {
        var scores: [Team: Int] = [:]
        let opponentTeam: Team = teams.first { $0.id != teams[announcingTeamIndex].id }!

        guard let pointsFait = Int(pointsFait), let annonce = Int(annonce) else {
            return nil
        }
        
        if pointsFait < annonce {
            scores[game.teams[announcingTeamIndex]] = 0
            scores[opponentTeam] = annonce + penalties
        } else if pointsFait > annonce {
            let pointsFaitOpponent = 162 - pointsFait
            scores[game.teams[announcingTeamIndex]] = pointsFait + annonce
            scores[opponentTeam] = 10 * Int(round(Double((pointsFaitOpponent + 5) / 10)))
        }
        
        return scores
    }
}
