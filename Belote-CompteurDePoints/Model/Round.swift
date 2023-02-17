//
//  Round.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import Foundation

class Round: Identifiable {
    let id = UUID()
    let teams: [Team]
    @Published var scores: [Team: Int]
    @Published var announcingTeamIndex = 0
    @Published var selectedColor = 0
    @Published var annonce = ""
    @Published var belote = false
    @Published var beloteBeneficiary = 0
    @Published var contree = false
    @Published var surContree = false
    @Published var pointsFait = ""
    @Published var showColorPicker = false
    
    init(teams: [Team], scores: [Team : Int], announcingTeamIndex: Int = 0, selectedColor: Int = 0, annonce: String = "", belote: Bool = false, beloteBeneficiary: Int = 0, contree: Bool = false, surContree: Bool = false, pointsFait: String = "", showColorPicker: Bool = false) {
        self.teams = teams
        self.scores = scores
        self.announcingTeamIndex = announcingTeamIndex
        self.selectedColor = selectedColor
        self.annonce = annonce
        self.belote = belote
        self.beloteBeneficiary = beloteBeneficiary
        self.contree = contree
        self.surContree = surContree
        self.pointsFait = pointsFait
        self.showColorPicker = showColorPicker
    }
}

