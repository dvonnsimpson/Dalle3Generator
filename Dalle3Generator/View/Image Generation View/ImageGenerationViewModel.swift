//
//  ImageGenerationViewModel.swift
//  Dalle3Generator
//
//  Created by Donovan Simpson on 4/13/24.
//

import Foundation

final class ImageGenerationViewModel: ObservableObject {
    @Published var generatedImages: [GeneratedImage]? = nil
    @Published var isLoading: Bool = false
    
    @MainActor func generateImage(prompt: String, style: String) async {
        do {
            isLoading = true
            generatedImages = try await NetworkManager.shared.generateImage(prompt: prompt, style: style).data
            isLoading = false
        } catch {
            print("\(error) from generateImage")
            isLoading = false
        }
    }
}
