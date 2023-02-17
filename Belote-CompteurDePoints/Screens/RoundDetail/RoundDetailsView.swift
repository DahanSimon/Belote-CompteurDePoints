//
//  RoundDetailsView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

import SwiftUI

struct RoundDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RoundDetailsViewModel
    @EnvironmentObject var game: Game
    
    var body: some View {
        Form {
            Section(header: Text("Annonce")) {
                HStack {
                    TextField("Annonce", text: $viewModel.currentRound.annonce)
                    Button(action: {
                        self.viewModel.showColorPicker.toggle()
                    }) {
                        Text(viewModel.colors[viewModel.currentRound.selectedColor])
                    }
                }
            }
            
            if viewModel.showColorPicker {
                VStack {
                    Button(action: {
                        self.viewModel.showColorPicker = false
                    }) {
                        Text("OK")
                    }
                    Picker("Couleur", selection: $viewModel.currentRound.selectedColor) {
                        ForEach(0 ..< viewModel.colors.count) {
                            Text(self.viewModel.colors[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            
            Section(header: Text("Equipe")) {
                Picker("Equipe", selection: $viewModel.currentRound.announcingTeamIndex, content: {
                    ForEach(0 ..< viewModel.teams.count) {
                        Text(viewModel.teams[$0].name).tag($0)
                    }
                })
                .onChange(of: viewModel.currentRound.announcingTeamIndex) { selectedTeam in
                    self.viewModel.currentRound.announcingTeamIndex = selectedTeam
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Options")) {
                Toggle(isOn: $viewModel.currentRound.belote) {
                    Text("Belote ?")
                }
                if viewModel.currentRound.belote {
                    Picker("Equipe", selection: $viewModel.currentRound.beloteBeneficiary, content: {
                        ForEach(0 ..< viewModel.teams.count) {
                            Text(viewModel.teams[$0].name).tag($0)
                        }
                    })
                    .onChange(of: viewModel.currentRound.beloteBeneficiary) { beloteBeneficiary in
                        self.viewModel.currentRound.beloteBeneficiary = beloteBeneficiary
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Toggle(isOn: $viewModel.currentRound.contree) {
                    Text("Contrée ?")
                }
                
                if viewModel.currentRound.contree {
                    Toggle(isOn: $viewModel.currentRound.surContree) {
                        Text("Sur Contrée ?")
                    }
                }
            }
            
            Section(header: Text("Points fait")) {
                TextField("Points fait", text: $viewModel.currentRound.pointsFait)
            }
            
            Section(header: Text("Résultat")) {
                Text(viewModel.result)
            }
            
            Button(action: {
                viewModel.addRound { success in
                    if success {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }) {
                Text("Valider")
            }
        }
        .navigationBarTitle("Manche")
    }
}
