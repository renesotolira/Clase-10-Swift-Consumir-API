//
//  PokemonDetailsView.swift
//  Api
//
//  Created by Rene SL on 05/11/23.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var pokemonList : PokemonListViewModel
    var body: some View {
        Text(pokemonList.pokemon.next)
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView().environmentObject(PokemonListViewModel())
    }
}
