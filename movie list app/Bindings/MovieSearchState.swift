//
//  MovieSearchState.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 20/04/23.
//

import SwiftUI
import Foundation
import Combine

class MovieSearchState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var query = ""
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var searchToken: AnyCancellable?
    
    let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func startObserve() {
        
        guard searchToken == nil else {return}
        
        self.searchToken = self.$query
            .map{ [weak self] text in
                self?.movies = nil
                self?.error = nil
                return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink{ [weak self] in self?.search(query: $0)}
    }
    
    func search(query: String) {
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else {
            return
        }
        
        self.movieService.searchMovie(query: query) { [weak self] (result) in
            switch result{
            case.success(let response):
                self?.movies = response.results
            case.failure(let error):
                self?.error = error as NSError
            }
        }
    }
    
    deinit {
        self.searchToken?.cancel()
        self.searchToken = nil
    }
}
