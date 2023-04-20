//
//  MovieService.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 18/04/23.
//

import Foundation

protocol MovieService{
    
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> () )
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse,MovieError>) -> ())
    
}

enum MovieListEndPoint: String, CaseIterable{
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String{
        switch self{
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
        }
    }
}

enum MovieError: Error{
    case apiError
    case noData
    case invalidResponse
    case invalidEndpoint
    case serializationError
    
    var localizedDescription: String{
        switch self{
        case .apiError: return "Failed to fetch Data"
        case .invalidEndpoint: return "Invalid Endpoint"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No Data Found"
        case .serializationError: return "Failed to decode Data"
        }
    }
}
