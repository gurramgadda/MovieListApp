//
//  Movie+Stub.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 18/04/23.
//

import Foundation

extension Movie{
    
    static var stubbedMovies : [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecode(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}

extension Bundle {
    func loadAndDecode<D: Decodable> (filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else{
            return nil
        }
        
        do{
            let data = try Data(contentsOf: url)
            let jsonDecoder = Utils.jsonDecoder
            let decodedModel = try jsonDecoder.decode(D.self, from: data)
            return decodedModel
        }catch {
            print("Error in loading/decoding json file: \(error)")
            throw error
        }
    }
}
