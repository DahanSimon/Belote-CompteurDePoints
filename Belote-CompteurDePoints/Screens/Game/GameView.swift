//
//  GameView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel = GameViewModel()
    @EnvironmentObject var game: Game
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("main-background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 10.0) {
                    
                    HStack {
                        Spacer()
                        if !game.rounds.isEmpty {
                            Button {
                                viewModel.resetGame(game: game)
                            } label: {
                                Image(systemName: "goforward")
                                    .font(.system(size: 20.0,weight: .bold))
                                    .foregroundColor(Color.white)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .frame(height: 50)
                    
                    HStack(alignment: .bottom) {
                        ForEach(game.teams.indices) { index in
                            VStack {
                                TeamTextField(teamName: $game.teams[index].name)
                                Text(String(game.teams[index].score))
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    NavigationLink {
                        RoundDetailsView(viewModel: RoundDetailsViewModel(game: game)).environmentObject(game)
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Nouvelle Manche")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                    .frame(width: 300, height: 80)
                    
                    if !game.rounds.isEmpty {
                        List {
                            ForEach(game.rounds) { round in
                                RoundListViewCell(round: round)
                                
                            }
                            .onDelete { index in
                                viewModel.deleteRound(game: game, index: index)
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
