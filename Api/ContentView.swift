//
//  ContentView.swift
//  Api
//
//  Created by Rene SL on 05/11/23.
//

import SwiftUI

struct ContentView: View {
   // @StateObject var pokemonList = PokemonListViewModel()
    @EnvironmentObject var pokemonList : PokemonListViewModel
    
    var body: some View {
        NavigationView(){
            VStack {
                
                Text("\(pokemonList.pokemon.count)")
                Text(pokemonList.pokemon.next)
                Text(pokemonList.pokemon.previous ?? "")
                
                
                List(){
                    ForEach(pokemonList.pokemon.results, id: \.self){  pokemon in
                        
                        NavigationLink(destination: PokemonDetailsView()){
                            VStack{
                                Text(pokemon.name)
                                Text(pokemon.url)
                            }
                        }
                    }
                }
            }
            
            .padding()
            .onAppear(){
                //pokemonList.getPokemonList()
                pokemonList.getPokemonListWithoutDecoder()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()  .environmentObject(PokemonListViewModel())
    }
}
