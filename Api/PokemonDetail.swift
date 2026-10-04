//
//  PokemonDetail.swift
//  Api
//
//  Created by Rene Soto Lira on 04/10/26.
//

import Foundation

struct PokemonDetail: Decodable {
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let front_default: String?
    }
}
