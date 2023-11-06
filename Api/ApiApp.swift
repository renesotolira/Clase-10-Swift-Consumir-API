//
//  ApiApp.swift
//  Api
//
//  Created by Rene SL on 05/11/23.
//

import SwiftUI

@main
struct ApiApp: App {
    var sharedViewModel = PokemonListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(sharedViewModel)
        }
    }
}
