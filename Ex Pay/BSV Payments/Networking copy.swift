//
//  Networking copy.swift
//  BSV Payments
//
//  Created by Jack Knight on 02/07/2021.
//

import SwiftUI
import Combine

class Networking: ObservableObject {
    @Published var requests = Set<AnyCancellable>()
    
    // MARK: FUNCS
    /// Fetches JSON and stores the result in requests = Set<AnyCancellable>()
    /// - Parameters:
    ///   - url: json url
    ///   - defaultValue: fail default json response
    ///   - completion: result or defaultValue
    func fetch<T: Decodable>(_ url: URL,
                             defaultValue: T,
                             completion: @escaping (T) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion )
            .store(in: &requests)
        
        
    }
}
