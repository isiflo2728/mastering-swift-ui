//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Isidoro Flores on 4/28/26.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Faile to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Faile to load \(file) as Data")
        }
        let decoder = JSONDecoder()
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(Formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode JSON")
        }
        
        return loaded
    }
}
