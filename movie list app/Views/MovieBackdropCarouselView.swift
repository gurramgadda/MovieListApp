//
//  MovieBackdropCarouseView.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 19/04/23.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 20){
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieBackdropCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 300, height: 200)
                        .padding(.leading, movie.id == self.movies.first!.id ? 20 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 20 : 0)
                    }
                }
            }
        }
    }
}

struct MovieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouselView(title: "Example", movies: Movie.stubbedMovies)
    }
}
