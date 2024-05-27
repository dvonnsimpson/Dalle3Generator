//
//  RemoteImage.swift
//  Dalle3 Generator
//
//  Created by Donovan Simpson on 4/13/24.
//

import Foundation

import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    func load(fromURL urlString: String) async {
        do {
            guard let uiImage = try await NetworkManager.shared.downloadImage(from: urlString) else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        } catch {
            print(error)
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        if let image = image {
            image.resizable().scaledToFit()
        } else {
            LoadingView()
        }
    }
}

struct Dalle3RemoteImage: View {
    @StateObject private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .task { await imageLoader.load(fromURL: urlString) }
        
        if let image = imageLoader.image {
            ShareLink(item: image, preview: SharePreview("my Dalle3 image"))
                .padding(.top)
        }
    }
}

#Preview {
    RemoteImage()
}
