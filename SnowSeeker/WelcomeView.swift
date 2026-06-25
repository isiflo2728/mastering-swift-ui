//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Isidoro Flores on 6/23/26.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            Text("Please select a resort from the left hand menu; swipe fromt he left edge to show it")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
