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
            .font(.title)
            .foregroundColor(.white)
            .frame(minHeight: 70.0,maxHeight: 70)
            .padding()
    }
}

struct TeamTextFields_Previews: PreviewProvider {
    static var previews: some View {
        TeamTextField(teamName: .constant("Team Name"))
    }
}
