//
//  EmptyRecipesView.swift
//  Fetch Take Home
//
//  Created by Antony Holshouser on 5/6/25.
//

import SwiftUI

struct EmptyRecipesView: View {
    let refreshRecipes: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Spacer(minLength: 0)
            
            Text("😱")
                .font(Font.system(size: 50))
                .frame(maxWidth: .infinity)
            
            Text("Oh no! There seems to be no recipes available right now!")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            Text("Our engineers are on our way to fix this issue as soon as possible! Since you saw this screen, that means \(Text("they have been immediately notified").bold()) of the issue.")
            
            Text("We deeply apologize for any inconvenience this may have caused. Please come back later as it may take some time for this issue to be solved.")
            
            Spacer(minLength: 0)
            
            Button {
                refreshRecipes()
            } label: {
                Text("Refresh")
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ViewController()
}
