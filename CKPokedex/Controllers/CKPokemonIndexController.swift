//
//  CKPokemonIndexController.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 24/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import IGListKit


class CKPokemonIndexController : ListSectionController {
    
    var pokemon : Pokemon?
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionView = collectionContext else {
            fatalError("CKPokemonIndecController doesnt have a cell")
        }
        return CGSize(width: collectionView.containerSize.width , height: 200)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: CKPokeCell.self, for: self, at: index) as? CKPokeCell else {
            fatalError()
        }
        
        guard let pokemon = pokemon else { return UICollectionViewCell()}

        cell.pokemonImage.image = #imageLiteral(resourceName: "charmander")
        cell.idLabel.setup(pokemon.urlString)
        cell.nameLabel.setup(pokemon.name)
        return cell
    }
    
    
    override func didUpdate(to object: Any) {
        pokemon = object as? Pokemon
    }
}





