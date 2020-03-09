//
//  SuperHeroRow.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 18/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroRow: View {
    var superHero: SuperHero

    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: superHero.photo!)
            .resizable()
            .scaledToFill()
            .frame(width: nil, height: 163, alignment: .center)
            .clipped()
            gradient()
            .accessibility(label: Text("Image of \(superHero.name)"))
            HStack(alignment: .bottom) {
                Text(superHero.name)
                    .foregroundColor(.white)
                    .font(.system(size: 16.0))
                Spacer()
                if superHero.isAvenger {
                    Image("ic_avenger_badge")
                        .accessibility(label: Text("\(superHero.name) Avenger Badge"))
                }
            }.padding()
        }
    }

    private func gradient() -> some View {
        let gradient = LinearGradient(
            gradient: .init(colors: [Color("gradientStartColor"), Color("gradientEndColor")]),
            startPoint: .init(x: 0.0, y: 0.6),
            endPoint: .init(x: 0.0, y: 1.0)
        )
        return Rectangle().fill(gradient)
    }
}

struct SuperHeroRow_Previews: PreviewProvider {
    static var previews: some View {
        SuperHeroRow(superHero: SuperHero(name: "Spider-Man",
        photo: URL(string: "https://x.annihil.us/u/prod/marvel/i/mg/6/60/538cd3628a05e.jpg"),
        isAvenger: true,
        description: "Bitten by a radioactive spider, high school student Peter Parker gained the speed, "
            + "strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start "
            + "a career using his new abilities. Taught that with great power comes great "
            + "responsibility, Spidey has vowed to use his powers to help people."))
        .previewLayout(.fixed(width: 414, height: 163))

    }
}
