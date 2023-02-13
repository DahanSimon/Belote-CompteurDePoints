//
//  RoundListView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

struct RoundListViewCell: View {
    
    let round: Round
    
    var body: some View {
        HStack {
            Text(String(round.scores[round.teams.first!] ?? 0))
                .multilineTextAlignment(.center)
                .padding(.leading)
            Spacer()
            Text(String(round.scores[round.teams.last!] ?? 0))
                .multilineTextAlignment(.center)
                .padding(.trailing)
        }
        .padding()
        .frame(width: 300, height: 80)
        .background(.white)
        .cornerRadius(15.0)
    }
}

struct RoundListView_Previews: PreviewProvider {
    static var previews: some View {
        let teams = [Team(name: "Nous"), Team(name: "Eux")]
        RoundListViewCell(round: Round(teams: teams, scores: [:]))
    }
}
