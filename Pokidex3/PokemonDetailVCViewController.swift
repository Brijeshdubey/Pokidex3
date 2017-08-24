//
//  PokemonDetailVCViewController.swift
//  Pokidex3
//
//  Created by Brijesh Dubey on 23/08/17.
//  Copyright © 2017 Brijesh Dubey. All rights reserved.
//

import UIKit

class PokemonDetailVCViewController: UIViewController {
    
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var mainimg: UIImageView!
    @IBOutlet weak var typelbl: UILabel!
    
    @IBOutlet weak var defencelbl: UILabel!
    
    @IBOutlet weak var heightlbl: UILabel!
    
    @IBOutlet weak var idlbl: UILabel!
    
    @IBOutlet weak var weightlbl: UILabel!
    
    @IBOutlet weak var attacklbl: UILabel!
    
    @IBOutlet weak var nextevolbl: UIImageView!
    @IBOutlet weak var curremtevolbl: UIImageView!
    @IBOutlet weak var evolbl: UILabel!
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label2.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainimg.image = img
        curremtevolbl.image = img
        
        idlbl.text = "\(pokemon.pokedexId)"
        
        
        pokemon.downloadPokemonDetail { 
            
            // whatever we write will only be called after the network call is complete!
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        attacklbl.text = pokemon.attack
        defencelbl.text = pokemon.defense
        heightlbl.text = pokemon.height
        weightlbl.text = pokemon.weight
        typelbl.text = pokemon.type
        detailLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            
            evolbl.text = "No Evolution"
            nextevolbl.isHidden = true
        } else {
            nextevolbl.isHidden = false
            nextevolbl.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionname) - LVL \(pokemon.nextEvolutionLevel)"
            
            evolbl.text = str
        }
        
    }
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
