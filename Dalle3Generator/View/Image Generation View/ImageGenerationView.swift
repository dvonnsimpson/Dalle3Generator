//
//  ImageGenerationView.swift
//  Dalle3Generator
//
//  Created by Donovan Simpson on 4/13/24.
//

import SwiftUI

struct ImageGenerationView: View {
    @StateObject var viewModel = ImageGenerationViewModel()
    @State var prompt = ""
    @State var style = "vivid"
    
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("Enter a prompt to generate an image", text: $prompt, axis: .vertical)
                .padding()
                .textFieldStyle(CustomBorder())
            
            HStack(alignment: .center) {
                Picker("", selection: $style) {
                    ForEach(Style.allCases, id: \.rawValue) { style in
                        Text(style.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.trailing)
                
                Button {
                    Task {
                        await viewModel.generateImage(prompt: prompt, style: style)
                    }
                } label: {
                    Text("Submit")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            
            Spacer()
            
            if let generatedImages = viewModel.generatedImages, let url = generatedImages.first?.url {
                Dalle3RemoteImage(urlString: url)
            } else if viewModel.isLoading {
                LoadingView()
            } else {
                PlaceholderView()
            }
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    ImageGenerationView()
}

enum Style: String, CaseIterable {
    case vivid
    case natural
}

struct CustomBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.black, lineWidth:1)
            )
    }
}
