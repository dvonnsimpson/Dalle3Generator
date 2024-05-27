//
//  PlaceholderView.swift
//  Dalle3Generator
//
//  Created by Donovan Simpson on 4/16/24.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Enter a prompt to create an image")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .bottom) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                .foregroundStyle(.black)
                
                ForEach(1..<4) {_ in
                    Circle()
                        .frame(height: 10)
                        .padding(.bottom)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlaceholderView()
}
