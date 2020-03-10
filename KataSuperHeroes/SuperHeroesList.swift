//
//  SuperHeroesList.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 19/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import SwiftUI

struct SuperHeroesList: View {
    @ObservedObject
    var viewModel: SuperHeroesViewModel

    var body: some View {
        Group {
            if self.viewModel.isLoading {
                LoadingSwiftView()
            } else {
                if viewModel.superHeroes.isEmpty {
                    Text("¯\\_(ツ)_/¯")
                } else {
                    NavigationView {
                        List {
                            ForEach(viewModel.superHeroes) { superHero in
                                ZStack {
                                    SuperHeroRow(superHero: superHero)
                                    NavigationLink(destination: ServiceLocator().provideSuperHeroDetail(superHero.name)) {
                                        EmptyView()
                                    }.buttonStyle(PlainButtonStyle())
                                }
                                .listRowInsets(EdgeInsets())
                            }
                        }
                        .navigationBarTitle("Kata Super Heroes")
                        .navigationViewStyle(StackNavigationViewStyle())
                        .accessibility(identifier: "List of SuperHeroes")
                        viewModel.superHeroes.first.map { superHero in
                            ServiceLocator().provideSuperHeroDetail(superHero.name)
                        }
                    }
                }
            }
        }
        .onAppear {
          self.viewModel.load()
        }
    }
}

struct SuperHeroesList_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ServiceLocator().provideSuperHeroesViewModel()
        viewModel.superHeroes = superHeroData
        viewModel.isLoading = false
        return SuperHeroesList(viewModel: viewModel)
    }
}
