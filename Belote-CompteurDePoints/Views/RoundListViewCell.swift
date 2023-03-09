//
//  RoundListView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

struct RoundListViewCell: View {
    
    @EnvironmentObject var game: Game
    
    var roundID: UUID
    
    var body: some View {
        if let round = game.rounds.first(where: { $0.id == roundID }),
                let team1 = round.teams.first,
                let team2 = round.teams.last,
                let scoreTeam1 = round.scores[team1],
                let scoreTeam2 = round.scores[team2]  {
            HStack {
                Text(String(scoreTeam1))
                    .multilineTextAlignment(.center)
                    .padding(.leading)
                Spacer()
                Text(String(scoreTeam2))
                    .multilineTextAlignment(.center)
                    .padding(.trailing)
            }
            .padding()
            .frame(width: 300, height: 80)
            .background(.white)
            .cornerRadius(15.0)
        } else {
            Text("Une erreur est survenu")
        }
    }
}

struct RoundListView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(name: "Nous"), Team(name: "Eux")]
        RoundListViewCell(roundID: UUID())
    }
}
