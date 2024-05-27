//
//  NetworkManager.swift
//  Dalle3 Generator
//
//  Created by Donovan Simpson on 4/13/24.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    let openAIAPIKey = "*INSERT API KEY HERE*"
    let imageGenerationUrlString = "https://api.openai.com/v1/images/generations"
    
    func generateImage(prompt: String, style: String) async throws -> GenerateImageResponse {
        guard let url = URL(string: imageGenerationUrlString) else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "model": "dall-e-3",
            "prompt": prompt,
            "n": 1,
            "style": style
        ]
        
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = bodyData
        
        request.setValue("Bearer \(openAIAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(GenerateImageResponse.self, from: data)
        } catch {
            throw NetworkingError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let image = UIImage(data: data) {
            return image
        } else {
            throw NetworkingError.invalidData
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
