//
//  MovieStore.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 18/04/23.
//

import Foundation

class MovieStore :MovieService{
        
    static var shared = MovieStore()
    private init(){}
    
    private let apiKey = "e6dc8c20ea0d4c49874b8fa5173a1309"
    private let baseUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(from endpoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadAndDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadAndDecode(url: url,params: [
            "append_to_response":"videos,credits"
        ] , completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadAndDecode(url: url, params: [
            "language":"en-US",
            "include_adult":"false",
            "region":"US",
            "query":query
        ], completion: completion)
    }
    
    private func loadAndDecode<D: Decodable>(url: URL, params: [String : String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()){
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params{
            queryItems.append(contentsOf :params.map({URLQueryItem(name: $0.key, value: $0.value)}) )
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalUrl = urlComponents.url else{
            completion(.failure(.invalidEndpoint))
            return
        }
                
        urlSession.dataTask(with: finalUrl) { [weak self] (data, response, error) in
            guard let self = self else {return}
            
            if(error != nil){
                self.executeCompletionInMainThread(with: .failure(.apiError), completion: completion)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            
            do{
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionInMainThread(with: .success(decodedResponse), completion: completion)
            }catch{
                self.executeCompletionInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
        
    }
    
    private func executeCompletionInMainThread<D: Decodable>(with result: Result<D,MovieError>, completion: @escaping ( Result<D,MovieError> ) -> ()){
        
        DispatchQueue.main.async {
            completion(result)
        }
        
    }
    
}
