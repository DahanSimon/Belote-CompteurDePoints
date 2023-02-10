//
//  TeamTextFields.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

struct TeamTextField: View {
    @Binding var teamName: String
    
    var body: some View {
        TextField("Team Name", text: $teamName, axis: .vertical)
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct TeamTextFields_Previews: PreviewProvider {
    static var previews: some View {
        TeamTextField(teamName: .constant("Team Name"))
    }
}
