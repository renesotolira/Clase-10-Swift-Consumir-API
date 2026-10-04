//
//  ContentView.swift
//  Api
//
//  Created by Rene Soto Lira on 04/10/26.
//

import SwiftUI

struct ContentView: View {
    // @State private var pokemonList = PokemonListViewModel()
    @Environment(PokemonListViewModel.self) private var pokemonList


    var body: some View {
        VStack {
            Text("\(pokemonList.pokemon.count)")
            Text(pokemonList.pokemon.next ?? "")
            Text(pokemonList.pokemon.previous ?? "")

            List(pokemonList.pokemon.results) { pokemon in
                VStack(alignment: .leading) {
                    Text(pokemon.name)
                        .font(.headline)
                    Text(pokemon.url)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .task {
            await pokemonList.getPokemonList()
        }
    }
}

#Preview {
    ContentView().environment(PokemonListViewModel())
}


