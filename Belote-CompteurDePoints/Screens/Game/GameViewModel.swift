//
//  GameViewModel.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    
    let team1 = Team(name: "Nous")
    let team2 = Team(name: "Eux")
    
    
    @Published var isShowingRoundDetailView = false
    
    func addRound(game: Game, round: Round) {
        game.rounds.append(round)
    }
    
    func deleteRound(game: Game, index: IndexSet) {
//        game.rounds.remove(atOffsets: index)
//        for round in game.rounds {
//            guard let team1 = game.teams.first, let team2 = game.teams.last else {
//                return
//            }
//            game.scores[team1]! += round.scores[team1] ?? 0
//            game.scores[team2]! += round.scores[team2] ?? 0
//        }
    }
    
    func resetGame(game: Game) {
        game.resetGame()
        
    }
}
