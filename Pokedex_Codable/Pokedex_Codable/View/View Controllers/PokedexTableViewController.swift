//
//  PokedexTableViewController.swift
//  Pokedex_Codable
//
//  Created by Briana Bayne on 6/21/23.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    var pokedex: PokedexTopLevel?
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingController.fetchPokdex { [weak self] result in
            switch result {
            case.success(let pokedex):
                DispatchQueue.main.async {
                    self?.pokedex = pokedex
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.errorDescription!)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedex?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexTableViewCell else {return UITableViewCell() }
        guard let pokedex = pokedex else {return UITableViewCell()}
        let resultsDict = pokedex.results[indexPath.row]
        cell.updateViews(pokemonResult: resultsDict)
        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "toDetailVC",
               let destination = segue.destination as? PokemonViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let cell = tableView.cellForRow(at: indexPath) as?  PokedexTableViewCell else { return }
        destination.pokemon = cell.pokemon
        destination.pokemonSpirte = cell.PokemonSprite
        
    }
}
