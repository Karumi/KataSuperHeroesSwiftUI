//
//  SuperHeroesViewModel.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 19/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import Foundation

class SuperHeroesViewModel: ObservableObject {
    @Published var isLoading = true

    @Published var superHeroes: [SuperHero] = []

    private let getSuperHeroes: GetSuperHeroes

    init(getSuperHeroes: GetSuperHeroes) {
        self.getSuperHeroes = getSuperHeroes
    }

    func load() {
        isLoading = true
        getSuperHeroes.execute { superHeroes in
            self.superHeroes = superHeroes
            self.isLoading = false
        }
    }
}
