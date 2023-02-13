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
                    TextField("Annonce", text: $viewModel.annonce)
                    Button(action: {
                        self.viewModel.showColorPicker.toggle()
                    }) {
                        Text(viewModel.colors[viewModel.selectedColor])
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
                    Picker("Couleur", selection: $viewModel.selectedColor) {
                        ForEach(0 ..< viewModel.colors.count) {
                            Text(self.viewModel.colors[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            
            Section(header: Text("Equipe")) {
                Picker("Equipe", selection: $viewModel.selectedTeam, content: {
                    ForEach(0 ..< viewModel.teams.count) {
                        Text(viewModel.teams[$0].name).tag($0)
                    }
                })
                .onChange(of: viewModel.selectedTeam) { selectedTeam in
                    self.viewModel.selectedTeam = selectedTeam
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Options")) {
                Toggle(isOn: $viewModel.belote) {
                    Text("Belote ?")
                }
                if viewModel.belote {
                    Picker("Equipe", selection: $viewModel.beloteBeneficiary, content: {
                        ForEach(0 ..< viewModel.teams.count) {
                            Text(viewModel.teams[$0].name).tag($0)
                        }
                    })
                    .onChange(of: viewModel.beloteBeneficiary) { beloteBeneficiary in
                        self.viewModel.beloteBeneficiary = beloteBeneficiary
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Toggle(isOn: $viewModel.contree) {
                    Text("Contrée ?")
                }
                
                if viewModel.contree {
                    Toggle(isOn: $viewModel.surContree) {
                        Text("Sur Contrée ?")
                    }
                }
            }
            
            Section(header: Text("Score")) {
                TextField("Score", text: $viewModel.score)
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

struct RoundDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RoundDetailsView(viewModel: RoundDetailsViewModel(game: Game(teams: [])))
    }
}
