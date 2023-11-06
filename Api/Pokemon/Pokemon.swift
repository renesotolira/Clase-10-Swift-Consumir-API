//
//  Pokemon.swift
//  Api
//
//  Created by Rene SL on 05/11/23.
//

import Foundation

struct Pokemon: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Results]
    
    struct Results: Decodable, Hashable{
        let name: String
        let url: String
    }
    
}
