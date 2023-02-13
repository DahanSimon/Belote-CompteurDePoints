//
//  GameListView.swift
//  Belote-CompteurDePoints
//
//  Created by Simon Dahan on 10/02/2023.
//

import SwiftUI

struct GameListView: View {
    
    var body: some View {
                
        VStack() {
            HStack {
                VStack {
                    Text("Nous")
                    Text("Score :  \n1500")
                }
                Text("VS")
                    .padding()
                VStack {
                    Text("Eux")
                    Text("Score : \n1400")
                }
            }
            .multilineTextAlignment(.center)
            .padding(10.0)
            Spacer()
            Text("Continuer")
                .frame(width: 280, height: 50)
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10.0)
            Spacer()
        }
        .frame(width: 300, height: 180)
        .background(Color.gray)
        .font(.system(size: 20, weight: .bold, design: .default))
        .cornerRadius(15.0)
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
