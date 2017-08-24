//
//  Pokemoncell.swift
//  Pokidex3
//
//  Created by Brijesh Dubey on 23/08/17.
//  Copyright © 2017 Brijesh Dubey. All rights reserved.
//

import UIKit

class Pokemoncell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    
    var pokemon: Pokemon!
    
    
    // to make corners rounded.
    required init?(coder aDecoder:  NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        label1.text = self.pokemon.name.capitalized
        imageView.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
