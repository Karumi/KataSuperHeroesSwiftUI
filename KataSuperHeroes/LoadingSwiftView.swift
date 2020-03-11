//
//  LoadingSwiftView.swift
//  KataSuperHeroes
//
//  Created by Davide Mendolia on 19/02/2020.
//  Copyright © 2020 GoKarumi. All rights reserved.
//

import SwiftUI

struct LoadingSwiftView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<LoadingSwiftView>) -> LoadingView {
        let loadingView = LoadingView()
        loadingView.color = UIColor(named: "loadingColor")
        return loadingView
    }

    func updateUIView(_ uiView: LoadingView, context: UIViewRepresentableContext<LoadingSwiftView>) {
        uiView.isHidden = false
    }
}

struct LoadingSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSwiftView()
    }
}
