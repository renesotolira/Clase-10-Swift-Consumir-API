//
//  ApiApp.swift
//  Api
//
//  Created by Rene Soto Lira on 04/10/26.
//

import SwiftUI

@main
struct ApiApp: App {
    @State private var sharedViewModel = PokemonListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
            // agregar esta otra línea
            .environment(sharedViewModel)


        }
    }
}
