//
//  MoviePosterView.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 19/04/23.
//

import SwiftUI

struct MoviePosterView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 10){
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                            MoviePosterCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 10 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 10 : 0)
                    }
                }
            }
            
        }
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
