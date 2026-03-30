//
//  PublicAPIService.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

final class PublicAPIService: APIServiceProtocol, @unchecked Sendable {
    func fetch<T: Decodable & Sendable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200 ... 299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(T.self, from: data)
    }
}
