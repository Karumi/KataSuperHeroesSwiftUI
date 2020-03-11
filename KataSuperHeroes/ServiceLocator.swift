//
//  RootWireframe.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ServiceLocator {

    func provideRootViewController() -> UIViewController {
        return  UIHostingController(rootView: provideSuperHeroesList())
    }

    func provideSuperHeroesList() -> SuperHeroesList {
        return SuperHeroesList(viewModel: provideSuperHeroesViewModel())
    }

    func provideSuperHeroDetail(_ superHeroName: String) -> SuperHeroDetail {
        return SuperHeroDetail(viewModel: provideSuperHeroDetailViewModel(superHeroName: superHeroName))
    }

    func provideSuperHeroDetailViewModel(superHeroName: String) -> SuperHeroDetailViewModel {
        let getSuperHeroByName = GetSuperHeroByName(repository: SuperHeroesRepository())
        return SuperHeroDetailViewModel(superHeroName: superHeroName, getSuperHeroByName: getSuperHeroByName)
    }

    func provideSuperHeroesViewModel() -> SuperHeroesViewModel {
        let getSuperHeroes = provideGetSuperHeroesUseCase()
        return SuperHeroesViewModel(getSuperHeroes: getSuperHeroes)
    }

    fileprivate func provideGetSuperHeroesUseCase() -> GetSuperHeroes {
        return GetSuperHeroes(repository: SuperHeroesRepository())
    }
}
