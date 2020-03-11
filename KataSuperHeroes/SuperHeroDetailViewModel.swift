//
//  SuperHeroDetailViewModel.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 19/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import Foundation

class SuperHeroDetailViewModel: ObservableObject {
    private let superHeroName: String
    private let getSuperHeroByName: GetSuperHeroByName

    @Published var isLoading = true

    @Published var superHero: SuperHero? = nil

    let title: String

    init(superHeroName: String, getSuperHeroByName: GetSuperHeroByName) {
        self.superHeroName = superHeroName
        self.getSuperHeroByName = getSuperHeroByName
        title = superHeroName
    }

    func load() {
        isLoading = true
        getSuperHeroByName.execute(superHeroName) { superHero in
            self.isLoading = false
            self.superHero = superHero
        }
    }

}
