//
//  ContentView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 08/02/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var game = Game(teams: [Team(name: "Nous"), Team(name: "eux")])
    var body: some View {
        GameView().environmentObject(game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
