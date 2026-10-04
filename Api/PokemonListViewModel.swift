//
//  PokemonListViewModel.swift
//  Api
//
//  Created by Rene Soto Lira on 04/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class PokemonListViewModel {
    var pokemon = Pokemon(count: -1, next: nil, previous: nil, results: [])
    var sprites: [String:URL] = [:]
    
    func loadSprite(for item: Pokemon.Results) async{
        print("URl a buscar es \(item.url)")
        guard sprites[item.id] == nil, let detailURL = URL(string: item.url) else {
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: detailURL)
            let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
            print("detail image \(detail)")
            
            if let front = detail.sprites.front_default, let imageURL = URL(string: front){
                sprites[item.id] = imageURL
            }
            
        }catch{
            if (error as? URLError)?.code != .cancelled {
               print("Error al cargar la imagen: \(error)")
            }
        }
    }
    
    func getPokemonList() async{
        let endPoint = "https://pokeapi.co/api/v2/pokemon?limit=1000"
        
        guard let apiURL = URL(string: endPoint) else {
            print("Url no válida o no definida")
            return
        }
        var urlRequest = URLRequest(url: apiURL)
        
        // Método: GET, POST, PUT, PATCH, DELETE
        urlRequest.httpMethod = "GET"
        
        // Tipo de contenido que esperamos recibir
        urlRequest.setValue("application/json",forHTTPHeaderField: "Accept")
        
        // Cabeceras (headers) en caso de que la petición las pida:
        // urlRequest.setValue("Bearer token123",
        //                     forHTTPHeaderField: "Authorization")
        // urlRequest.setValue("ios",
        //                     forHTTPHeaderField: "User-Agent")
        
        // Ejemplo de envío de parámetros POST (body en JSON):
        // urlRequest.httpMethod = "POST"
        // urlRequest.setValue("application/json",
        //                     forHTTPHeaderField: "Content-Type")
        // let parameters: [String: Any] = [
        //     "id_trainer": 1,
        //     "name": "Ash",
        //     "champion": true
        // ]
        // urlRequest.httpBody = try JSONSerialization
        //     .data(withJSONObject: parameters)
        do {
            let (data, response) = try await URLSession.shared
                .data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: sin respuesta del servidor")
                return
            }

            guard httpResponse.statusCode == 200 else {
                // Ejemplos: 404 - Not found, 500 - Server error
                print("Status \(httpResponse.statusCode)")
                return
            }

            // AQUÍ NUESTRA LÓGICA para procesar la respuesta
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)

            pokemon = decoded

        } catch {
            print("Error: \(error.localizedDescription)")
        }

    }
}

