//
//  Pokedex.swift
//  Pokedex_Codable
//
//  Created by Briana Bayne on 6/21/23.
//

import Foundation


struct PokedexTopLevel: Decodable {
    
    let next: String
    let results: [ResultDict]
}

struct ResultDict: Decodable{
    let name: String
    let url: String
    
}


