//
//  FavCountryView.swift
//  iOS-Assignment3
//
//  Created by Olivia Gita Amanda Lim on 6/5/2024.
//

import SwiftUI

struct FavCountryView: View {
    var body: some View {
        VStack {
            Text("FAVOURITE COUNTRY!")
                .font(.custom("MontserratAlternates-SemiBold", size: 45))
                .foregroundStyle(.purple1)
                .multilineTextAlignment(.center)
            Spacer()
            Text("PUT THE MAP HERE")
            Spacer()
            Text("The list of favourite country!")
            Spacer()
        }
    }
}

#Preview {
    FavCountryView()
}
