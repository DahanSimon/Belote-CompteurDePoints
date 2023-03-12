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
        return currentRound.contree ? 160 : 0
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
        let announcingTeam: Team = game.teams[currentRound.announcingTeamIndex]

        guard let pointsFait = Int(currentRound.pointsFait), let annonce = Int(currentRound.annonce) else {
            return nil
        }
        
        if currentRound.capot {
            scores[announcingTeam] = (currentRound.capotAnnounced ? 500 : (250 + annonce))
            scores[opponentTeam] = 0
        } else if currentRound.capotAnnounced {
            scores[announcingTeam] = 0
            scores[opponentTeam] = currentRound.capotAnnounced ? 500 : (250 + annonce)
        }
        
        if pointsFait < annonce {
            scores[announcingTeam] = 0
            scores[opponentTeam] = (annonce + penalties) * (currentRound.surContree ? 2 : 1)
        } else if pointsFait >= annonce {
            if currentRound.contree {
                scores[opponentTeam] = 0
                scores[announcingTeam] = (annonce + penalties) * (currentRound.surContree ? 2 : 1)
            } else {
                scores[announcingTeam] = pointsFait + annonce
                let pointsFaitOpponent = 162 - pointsFait
                scores[opponentTeam] = 10 * Int(round(Double((pointsFaitOpponent + 5) / 10)))
            }
        }
        
        return scores
    }
}

func calculerPointsBeloteCoinchee(pointFait: Int, pointAnnonce: Int, contree: Bool = false, surcontree: Bool = false, capot: Bool = false, chute: Bool = false) -> (Int, Int) {
    var pointsAnnonceur = 0
    var pointsDefenseur = 0

    // Calcul des points de contrat
    if capot {
        if pointFait == 162 {
            pointsAnnonceur += 500
        } else {
            if pointAnnonce == 0 {
                pointsDefenseur += 500
            } else {
                pointsDefenseur += 162
            }
        }
    } else {
        if pointFait >= pointAnnonce {
            if contree {
                let points = (pointAnnonce + 160) * (surcontree ? 4 : 2)
                pointsAnnonceur += points
            } else {
                pointsAnnonceur += pointAnnonce + pointFait - 162
            }
        } else {
            if contree {
                let points = (pointAnnonce + 160) * (surcontree ? 4 : 2)
                pointsDefenseur += points
            } else {
                pointsDefenseur += pointAnnonce + 160
            }
        }
    }

    return (pointsAnnonceur, pointsDefenseur)
}


/*
 Cas 1 : point fait >= point annonce
         point annonceur = points fait + point annonce
         point defenseur = point fait - 162

 Cas 2 : point fait < point annonce
         point annonceur = 0
         point defenseur = point anonce + 160

 Cas 3 : Cas 1 contree
         point annonceur = (point annonce + 160) * 2
         point defenseur = 0

 Cas 4 : Cas 2 contree
         point annonceur = 0
         point defenseur = (point annonce + 160) * 2
 
 Cas 5 : Capot annonce fait
         point annonceur = 500
         point defenseur = 0
 
 Cas 5 : Capot annonce chute
         point annonceur = 0
         point defenseur = 500
 
 Cas 6 : Capot non annonce fait
         point annonceur = point anonce + 250
         point defenseur = 0
 
 Cas 7 : Capot annonce contree (surcontree) chute
         point annonceur = 0
         point defenseur = 1000 ( 2000 si sur contree )
 
 Cas 8 : Capot annonce contree (surcontree) fait
         point annonceur = 1000 ( 2000 si sur contree )
         point defenseur = 0
 */
