//
//  EpisodeViewModel.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

/*
    Para poder realizar la optimización y hacer mas eficiente la llamada al api, se pueden realizar mejoras como el uso de
    cache, reutilizar sesiones, y optimizacion del manejo de errores.
    
    1. Reutilizar el URLSession: Se puede reutilizar una unica instancia de URLSession para hacer la llamada mas eficiente y permite
    modificar las configuraciones, como el manejo de cookies o reutilizacion de conexiones.
    
    2. Usar cache: Se puede utilizar el cache para evitar que la información que ya ha sido descargada se descargue de nuevo en caso
    de ser solicitada en un tiempo determinado, en este caso de 10 segundos.
    
    3. Timeout: Se puede ajustar el tiempo de espera de cada request, y agregar la posibilidad de hacer reintentos a la llamada del api en caso de fallar
 */

import Foundation

class EpisodeViewModel: ObservableObject {
    @Published var episode: Episode?
    @Published var isLoading = true
    
    // Reutilización de la URLSession para toda la clase
    private let session: URLSession
    
    init() {
        // Configuramos una URLSession con almacenamiento en caché
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad  // Usa caché si está disponible
        configuration.timeoutIntervalForRequest = 10  // 10 segundos de timeout
        session = URLSession(configuration: configuration)
    }
    
    func getEpisodeInfo(from urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad  // Usar cache si hay disponible

        // llamada en segundo plano para no bloquear el hilo principal
        let (data, response) = try await session.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decodificar los datos en segundo plano
        DispatchQueue.global(qos: .background).async {
            do {
                let decodedEpisode = try JSONDecoder().decode(Episode.self, from: data)
                
                // Actualizamos el UI en el hilo principal
                DispatchQueue.main.async {
                    self.episode = decodedEpisode
                    self.isLoading = false
                }
            } catch {
                print("Failed to decode: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
