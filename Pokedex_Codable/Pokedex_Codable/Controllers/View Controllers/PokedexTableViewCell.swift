//
//  PokedexTableViewCell.swift
//  Pokedex_Codable
//
//  Created by Briana Bayne on 6/21/23.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    var pokemon: Pokemon?
    var PokemonSprite: UIImage?
    // MARK: - Methods
    
    func updateViews(pokemonResult:ResultDict) {
        pokemonNameLabel.text = pokemonResult.name
        NetworkingController.fetchPokemon(with: pokemonResult.name) { [weak self] result in
            switch result {
            case.success(let pokemon):
                self?.pokemon = pokemon
                self?.fetchPokemonImage(pokemon: pokemon)
            case.failure(let error):
                print(error.errorDescription!)
            }
            
        }
    }
    func fetchPokemonImage(pokemon: Pokemon) {
        NetworkingController.fetchImage(for: pokemon) { [weak self] result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self?.PokemonSprite = image
                    self?.pokemonImage.image = image
                    self?.pokemonIdLabel.text = "#\(pokemon.id)"
                    self?.pokemonNameLabel.text = pokemon.name
                }
            case.failure(let failure):
                print(failure.errorDescription!)
            }
        }
        
    }
    
}
