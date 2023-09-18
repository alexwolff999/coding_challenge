//
//  StarWarsView.swift
//  star_wars
//
//  Created by Alexander Wolff on 18.09.23.
//

import SwiftUI

struct StarWarsView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                content
            }
        }

    }
}
