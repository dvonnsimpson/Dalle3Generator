//
//  GenerateImageResponse.swift
//  Dalle3Generator
//
//  Created by Donovan Simpson on 4/13/24.
//

import Foundation

struct GenerateImageResponse: Codable {
    let data: [GeneratedImage]?
}

struct GeneratedImage: Codable {
    let url: String?
}
