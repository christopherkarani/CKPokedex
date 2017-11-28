//
//  NetworkService.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 27/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import TRON


protocol NetworkService: class {
    var tron : TRON { get }
    func fetchPokemon(completion: @escaping (([Pokemon]) -> Void))
    func fetchPokemonData(with urlString: String, completion: @escaping((PokemonData) -> Void))
}

extension NetworkService where Self: PokemonNetwork {

    
    func fetchPokemon(completion: @escaping (([Pokemon]) -> Void)) {
        let request : APIRequest<PokeCenter, PokemonError> = tron.request(Path.pokemon)
        request.method = .get
        request.perform(withSuccess: { (pokeCenter) in
            completion(pokeCenter.pokemon)
        }) { (error) in
            print(error)
        }
    }
    
    func fetchPokemonData(with urlString: String, completion: @escaping((PokemonData) -> Void)) {
        let rawString = String.init(describing: urlString.prefix(34))
        let indexString = urlString.replacingOccurrences(of: rawString, with: "")
        let path = Path.pokemon + indexString
        let reqest : APIRequest<PokemonData,PokemonError> = tron.request(path)
        reqest.perform(withSuccess: { (data) in
            print("Data retrival complete")
            completion(data)
        }) { (error) in
            print(error)
        }
    }
}


