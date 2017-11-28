//
//  HomeController.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import IGListKit
import TRON

protocol HomeControllerDelegate: class {
    func reloadAdapter()
}

private let reuseIdentifier = "Cell"

class HomeController: UICollectionViewController {
    var networkService : NetworkService
    var pokemons = [Pokemon]()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupIGListKit()
        fetchData()
    }
    
    func reloadAdapter() {
        self.adapter.reloadData(completion: nil)
    }
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupIGListKit() {
        adapter.collectionView = collectionView
        collectionView?.backgroundColor = .white
        adapter.dataSource = self
    }
}

// DataSource

extension HomeController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return pokemons
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return CKPokemonIndexController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
//Network
extension HomeController {
    func fetchData() {
        networkService.fetchPokemon { (pokemons) in
            self.pokemons = pokemons
            self.adapter.reloadData(completion: nil)
        }
    }
}

