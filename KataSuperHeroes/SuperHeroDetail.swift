//
//  SuperHeroDetail.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 19/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroDetail: View {
    @ObservedObject
    var viewModel: SuperHeroDetailViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingSwiftView()
                .onAppear() {
                    self.viewModel.load()
                }
            } else {
                viewModel.superHero.map { superHero in
                    VStack(alignment: .leading) {
                        ZStack(alignment: .bottomTrailing) {
                            WebImage(url: superHero.photo!)
                            .resizable()
                            .scaledToFit()
                            if superHero.isAvenger {
                                Image("ic_avenger_badge")
                                    .accessibility(label: Text("Avengers Badge"))
                                    .padding()
                            }
                        }
                        Text(superHero.name)
                            .accessibility(label: Text("Superhero name"))
                            .accessibility(value: Text(superHero.name))
                            .foregroundColor(.white)
                            .padding()
                        Text(superHero.description)
                            .accessibility(label: Text("Superhero description"))
                            .accessibility(value: Text(superHero.description))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    .background(Color("backgroundColor"))
                    .navigationBarTitle(Text(superHero.name), displayMode: .inline)
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct SuperHeroDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ServiceLocator().provideSuperHeroDetailViewModel(superHeroName: "")
        viewModel.isLoading = false
        viewModel.superHero = superHeroData[1]
        return SuperHeroDetail(viewModel: viewModel)
    }
}
