//
//  MovieBackdropCard.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 18/04/23.
//

import SwiftUI

struct MovieBackdropCard: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
//        NavigationLink(destination: MovieDetailView(location: location)) {
            VStack(alignment: .leading){
                ZStack{
                    Rectangle().fill(Color.gray.opacity(0.3))
                    
                    if self.imageLoader.image != nil{
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                    }
                }
                .aspectRatio(16/9,contentMode: .fit)
                .cornerRadius(10)
                .shadow(radius: 4)
                
                Text(movie.title)
                    .lineLimit(1)
            }
//        }
        .onAppear{
            self.imageLoader.loadImage(with: self.movie.backgroundUrl)
        }
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}
