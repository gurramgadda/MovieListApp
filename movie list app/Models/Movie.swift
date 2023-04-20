//
//  Movie.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 18/04/23.
//

import Foundation

struct MovieResponse: Decodable{
    
    let results : [Movie]
    
}

struct Movie: Decodable, Identifiable{
    
    let id : Int
    let title : String
    let posterPath : String?
    let backdropPath : String?
    let overview : String
    let voteAverage : Double
    let runTime : Int?
    let releaseDate: String?
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let duartionFarmatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month]
        return formatter
    }()
    
    var backgroundUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else{
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runTime = self.runTime, runTime > 0 else{
            return "n/a"
        }
        return Movie.duartionFarmatter.string(from: TimeInterval(runTime) * 60 ) ?? "n/a" 
    }
    
    var cast: [MovieCast]?{
        credits?.cast
    }
    
    var crew: [MovieCrew]?{
        credits?.crew
    }
    
    var directors: [MovieCrew]?{
        crew?.filter{ $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]?{
        crew?.filter{ $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]?{
        crew?.filter{ $0.job.lowercased() == "story" }
    }
    
    var youtubeTrailers: [MovieVideo]? {
        return videos?.results.filter{ $0.youtubeURL != nil }
    }
    
}


struct MovieGenre: Decodable {
    var name:String
}

struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let name: String
    let job: String
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else{
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
