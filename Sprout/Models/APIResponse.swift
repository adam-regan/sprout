//
//  APIResponse.swift
//  Sprout
//
//  Created by Adam Regan on 30/03/2026.
//

import Foundation

struct APIResponse<T: Decodable>: nonisolated Decodable {
    let entity: String
    let exportedAt: String
    let rowCount: Int
    let data: [T]
}
