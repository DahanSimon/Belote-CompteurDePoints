//
//  Round.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import Foundation

struct Round: Identifiable {
    let id = UUID()
    let teams: [Team]
    let scores: [Team: Int]
}
