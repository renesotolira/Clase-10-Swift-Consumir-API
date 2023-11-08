//
//  Connection.swift
//  Api
//
//  Created by Rene SL on 05/11/23.
//

import Foundation
import Combine

class PokemonListViewModel : ObservableObject {
    @Published var pokemon: Pokemon
    
    init(){
        self.pokemon = Pokemon(count: -1, siguiente: "" , previous: "" , results: [])
    }
    

    
    func getPokemonListWithoutDecoder(){
   
        let urlRequest = configUrlRequest()
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print("Error: " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Error: Incapaz de conectar o recibir respuesta del servidor")
                return
            }
            
            
            if response.statusCode == 200 {
                
                guard let data = data else {
                    print("Respuesta vacía")
                    return
                }
                
                /*Nuestra lógica de obtención, códificación y asignación de datos
                 dentro de un Dispatch y do Catch
                 */
                DispatchQueue.main.async {
                    do {
   
                        let json  = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                        let jsonData  = json as! NSDictionary
                        
                        let count = jsonData["count"] as? Int ?? 0
                        let next = jsonData["next"] as? String ?? ""
                        let previous = jsonData["previous"] as? String ?? ""
                        //NSDictionary para tratarlo Json Object
                        //NSArray para tratarlo como Json Array
                        let jsonArray = jsonData["results"] as! NSArray
                        var results : [Results] = []
                        
                        for item in jsonArray as! [NSDictionary]{
                           
                                let name = item["name"] as? String ?? ""
                                let url = item["url"] as? String ?? ""
                                let result = Results( name: name ,url: url )
                                results.append(result)
                       
                        }
                        self.pokemon = Pokemon(count: count, siguiente: next , previous: previous , results: results )
                        
                    } catch let error {
                        print("Error al decodificar JSON \(error)")
                        return
                    }
                }
               
            }else{
                print("Status diferente a 200. Ejemplos: 500 - Internal server error, 400 - Not found , etc.")
                return
            }
            
        })
        task.resume()
    }
    
    private func configUrlRequest() -> URLRequest{
        let endPoint : String = "https://pokeapi.co/api/v2/pokemon"
        
        guard let apiURL = URL(string: endPoint) else{
            fatalError("Url no válida o no definida")
        }
        
        var urlRequest = URLRequest(url: apiURL)
    
       /*Configuración de Cabeceras(Headers) en caso que la petición lo demande:
        urlRequest.addValue("token123", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("ios", forHTTPHeaderField: "User-Agent")
        */
        
        //Especificar tipo de contenido: XML, JSON, String,etc.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Mencionar tipo de método GET, POST, PUT, PATCH, DELETE
        urlRequest.httpMethod = "GET"
    
        /*Ejemplo de inicialización y envío parametros POST
        let parameters: [String: Any] = [
            "id_trainer" : 1,
            "name" : "Ash",
            "champion" : true,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        urlRequest.httpBody = jsonData
        */

        return urlRequest
    }
    
    func getPokemonList(){
   
        let urlRequest = configUrlRequest()
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print("Error: " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Error: Incapaz de conectar o recibir respuesta del servidor")
                return
            }
            
            
            if response.statusCode == 200 {
                
                guard let data = data else {
                    print("Respuesta vacía")
                    return
                }
                
                /*Nuestra lógica de obtención, códificación y asignación de datos
                 dentro de un Dispatch y do Catch
                 */
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
                        /* Sí decodificamos un Json Object sería como este ejmplo pero si fuera un JSON Array sería [Pokemon].self
                        let decoded = try JSONDecoder().decode( MODELO_OBJECT .self, from: data)
                        let decoded = try JSONDecoder().decode( [MODELO_ARRAY] .self, from: data)
                        */
                        self.pokemon = decoded
                        
                    } catch let error {
                        print("Error al decodificar JSON \(error)")
                        return
                    }
                }
               
            }else{
                print("Status diferente a 200. Ejemplos: 500 - Internal server error, 400 - Not found , etc.")
                return
            }
            
        })
        task.resume()
    }
    
    
}
