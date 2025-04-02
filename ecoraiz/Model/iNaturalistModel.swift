// En INaturalistModels.swift

import Foundation

// --- Modelos Codable para la API de iNaturalist ---

// Modelo principal de la respuesta
struct ObservationResponse: Codable {
    let totalResults: Int
    let page: Int
    let perPage: Int
    let results: [Observation] // Array de observaciones

    // Necesario si las claves JSON son snake_case y las propiedades Swift son camelCase
     enum CodingKeys: String, CodingKey {
         case totalResults = "total_results"
         case page
         case perPage = "per_page"
         case results
     }
}

// Modelo para cada Observación
struct Observation: Codable, Identifiable {
    let id: Int
    let speciesGuess: String?
    let observedOnString: String? // La fecha como texto desde la API
    let placeGuess: String?       // El lugar como texto desde la API
    let user: iNatUser?           // El usuario (renombrado)
    let photos: [Photo]?          // Array de fotos
    let uri: String?              // URL a la página web de la observación
    let taxon: Taxon?             // Información taxonómica (añadido)

    enum CodingKeys: String, CodingKey {
        case id
        case speciesGuess = "species_guess"
        case observedOnString = "observed_on_string"
        case placeGuess = "place_guess"
        case user // La clave JSON sigue siendo "user", decodificará a iNatUser
        case photos
        case uri
        case taxon // Añadido para decodificar el objeto taxon
    }
}

// Modelo para el objeto Taxon anidado dentro de Observation
struct Taxon: Codable {
    let id: Int
    let name: String?                 // Nombre científico (ej: "Pieris rapae")
    let preferredCommonName: String?  // Nombre común preferido (ej: "Small White")

    enum CodingKeys: String, CodingKey {
         case id
         case name
         case preferredCommonName = "preferred_common_name" // Mapea la clave JSON
     }
}

// Modelo para el Usuario (asegúrate que sea este el que uses)
struct iNatUser: Codable {
    let id: Int
    let login: String
}

// Modelo para cada Foto
struct Photo: Codable {
    let id: Int
    let url: String? // Contiene la URL base de la foto
}
