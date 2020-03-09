//
//  SuperHeroesViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 13/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import KIF
import Nimble
import UIKit
import SwiftUI
@testable import KataSuperHeroes

class SuperHeroesViewControllerTests: AcceptanceTestCase {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCaseIfThereAreNoSuperHeroes() {
        givenThereAreNoSuperHeroes()

        openSuperHeroesViewController()

        tester().waitForView(withAccessibilityLabel: "¯\\_(ツ)_/¯")
    }

    func testShowsSuperHeroNamesIfThereAreSuperHeroes() {
        let superHeroes = givenThereAreSomeSuperHeroes()
        openSuperHeroesViewController()

        for i in 0..<superHeroes.count {
            tester().waitForView(withAccessibilityLabel: superHeroes[i].name)
        }
    }

    func testShowsAvengersBadgeIfASuperHeroIsPartOfTheAvengersTeam() {
        let superHeroes = givenThereAreSomeAvengers()
        openSuperHeroesViewController()

        for i in 0..<superHeroes.count {
            tester().waitForView(withAccessibilityLabel: "\(superHeroes[i].name) Avenger Badge")
        }
    }

    func testDoNotShowAvengersBadgeIfSuperHeroesAreNotPartOfTheAvengersTeam() {
        let superHeroes = givenThereAreSomeSuperHeroes()

        openSuperHeroesViewController()

        for i in 0..<superHeroes.count {

            tester().waitForAbsenceOfView(withAccessibilityLabel:  "\(superHeroes[i].name) Avenger Badge")
        }
    }

    func testDoNotShowEmptyCaseIfThereAreSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes()

        openSuperHeroesViewController()

        tester().waitForAbsenceOfView(withAccessibilityLabel: "¯\\_(ツ)_/¯")
    }

    func testDoNotShowLoadingViewIfThereAreSomeSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes()

        openSuperHeroesViewController()

        tester().waitForAbsenceOfView(withAccessibilityLabel: "LoadingView")
    }

    func testOpensSuperHeroDetailViewControllerOnSuperHeroTapped() {
        let superHeroIndex = 1
        let superHeroes = givenThereAreSomeSuperHeroes()
        let superHero = superHeroes[superHeroIndex]
        openSuperHeroesViewController()

        tester().waitForView(withAccessibilityLabel: "Image of \(superHero.name)")
        tester().tapView(withAccessibilityLabel: "Image of \(superHero.name)")

        tester().waitForAbsenceOfView(withAccessibilityLabel: "Superhero name")
    }

    fileprivate func givenThereAreSomeAvengers() -> [SuperHero] {
        return givenThereAreSomeSuperHeroes(avengers: true)
    }

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: NSURL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg") as URL?,
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    @discardableResult
    fileprivate func openSuperHeroesViewController() -> UIHostingController<SuperHeroesList> {
        var superHeroesList = ServiceLocator().provideSuperHeroesList()
        superHeroesList.viewModel = SuperHeroesViewModel(getSuperHeroes: GetSuperHeroes(repository: repository))
        let vc = UIHostingController(rootView: superHeroesList)
        present(viewController: vc)
        tester().waitForAnimationsToFinish()
        return vc
    }
}
