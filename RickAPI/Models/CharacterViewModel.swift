//
//  CharacterViewModel.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

/*
    Opciones Alternativas para hacer llamadas de api en swift:
 
    1. URLSession con async/await:
    Esta es la opcion mas moderna que tiene swift para realizar llamadas a apis, aprovechando grandemente las capacidades de
    concurrencia de Swift 5.5 con async/await. Es una manera muy eficiente, limpia y permite escribir codigo que se parece al
    de la programacion sincrona, sin necesidad de manejar manualmente los hilos ni usar completion handlers.
 
        Ventajas:
            1. Código limpio y eficiente.
            2. Integración de concurrencia (manejar varios tasks a la vez).
            3. Manejo de errores con try, catch y throw.
        Desventajas:
            1. Solo esta disponible para IOS 15 en adelante.
    Este ejemplo se puede ver aplicado en la llamada al api en el EpisodeViewModel.
 
    2. URLSession con completion handlers:
    Esta es la forma original de swift para manejar peticiones HTTP. Es util cuando se necesita compatibilidad con versiones
    de IOS anteriores a la 15 o si se necesita tener varios hilos concurrentes sin bloquear el hilo principal.
 
        Ventajas:
            1. Funcion con versiones anteriores de IOS (13 y 14)
            2. Permite manejar llamadas a api sin necesidad de usar async/await
        Desventajas:
            1. El codigo es bastante verboso y se complica demasiado, especialmente con multiples operaciones anidadas.
            2. Es mas dificil de mantener y leer el codigo.
    
    3. Alamofire
    Alamofire es una libreria muy popular que simplifica mucho realizar llamadas a apis en Swift. Este es de gran utilidad cuando
    se necesitan realizar operaciones mas complejas, como el manejo de multiples solicitudes, manipulacion de archivos, entre otros.
        
        Ventajas:
            1. Abstracción sobre URLSession, con una sintaxis mas sencilla
            2. Soporta multipart forms, autenticación, etc.
            3. Es un manejador de solicitudes mas completo
        Desventajas:
            1. Agrega una dependencia adicional al proyecto
            2. Es excesivo para aplicaciones sencillas
    Un ejemplo del uso de alamofire se puede ver en este archivo para realizar una llamada al api de personajes
 */

import Foundation
import Alamofire

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func getCharacterInfo(completion: @escaping (Result<[Character], Error>) -> Void) {
        let url = "https://rickandmortyapi.com/api/character"
        
        AF.request(url).responseDecodable(of: ResponseCharacter.self) { response in
            switch response.result {
            case .success(let apiResponse):
                DispatchQueue.main.async {
                    self.characters = apiResponse.results
                    completion(.success(apiResponse.results))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
