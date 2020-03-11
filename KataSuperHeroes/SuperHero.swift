//
//  SuperHero.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

struct SuperHero {

    let name: String
    let photo: URL?
    let isAvenger: Bool
    let description: String

}

extension SuperHero: Identifiable {
    var id: String {
        return self.name
    }
}
