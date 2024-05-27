//
//  LoadingView.swift
//  Dalle3Generator
//
//  Created by Donovan Simpson on 4/16/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Creating that image now...")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            ProgressView()
                .controlSize(.large)
        }
        .padding()
            
    }
}

#Preview {
    LoadingView()
}
