//
//  APIServiceProtocol.swift
//  Sprout
//
//  Created by Adam Regan on 20/03/2026.
//

import Foundation

protocol APIServiceProtocol : Sendable{
    func fetch<T: Decodable & Sendable>(from urlString: String) async throws -> T
}

