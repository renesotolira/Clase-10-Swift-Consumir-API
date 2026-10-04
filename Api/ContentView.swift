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
                
                HStack{
                    AsyncImage(url: pokemonList.sprites[pokemon.id]){ image in
                        
                        image.resizable().scaledToFit()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text(pokemon.name.capitalized)
                            .font(.headline)
                        Text(pokemon.url)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                }.task {
                    await pokemonList.loadSprite(for: pokemon)
                }
            }
        }
        .task {
            await pokemonList.getPokemonList()
        }
    }
}

#Preview {
    ContentView().environment(PokemonListViewModel())
}


