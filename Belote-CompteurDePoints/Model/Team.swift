//
//  Team.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import Foundation
import SwiftUI

final class Team: ObservableObject, Hashable {
    
    let id = UUID()
    var name: String
    var score = 0
    
    init(name: String, score: Int = 0) {
        self.score = score
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
}

