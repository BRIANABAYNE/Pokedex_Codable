//
//  PokemonViewController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.delegate = self
        pokemonMovesTableView.dataSource = self
        updateViews(for: pokemon)
    }
    // MARK: - Properties
    var pokemon: Pokemon?
    var pokemonSpirte: UIImage?
    
    // MARK: - Methos
    func updateViews(for pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return } 
        self.pokemonSpriteImageView.image = pokemonSpirte
        self.pokemonIDLabel.text = ("No:\(pokemon.id)")
        self.pokemonNameLabel.text = pokemon.name.capitalized
        self.pokemonMovesTableView.reloadData()
    }
}

// MARK: - Extension
extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        guard let pokemon = pokemon else {return UITableViewCell() }
        let moveDict = pokemon.moves[indexPath.row]
        cell.textLabel?.text = moveDict.move.name
        return cell
    }
}



