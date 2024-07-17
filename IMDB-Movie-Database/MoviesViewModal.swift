//  MoviesViewModel.swift
//  IMDB-Movie-Database
//  Created by Abhishek Sharma on 08/07/24.

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let thumbnailUrl: String
    let rating: Double
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailUrl = "poster_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

enum MovieCategory: String {
    case trending = "trending/movie/day"
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
}

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var isLoading = false

    func fetchMovies(for category: MovieCategory) async {
        isLoading = true
        defer { isLoading = false }

        guard let url = URL(string: "https://api.themoviedb.org/3/\(category.rawValue)") else {
            print("Invalid URL")
            return
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5N2FmMTNkY2JmZjNkMjZhMmY5MGVjOGIxOGY5MTRjYiIsIm5iZiI6MTcyMDI4NzQ2My40OTc2NTEsInN1YiI6IjY2ODYzZGQ5NjNkMGI1ZDdmYTFhNjNiMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XfVlnNnZzErT8deDH8bGik1upUiH7jLewi6slp_pGwM"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

            switch category {
            case .trending:
                trendingMovies = decodedResponse.results
            case .nowPlaying:
                nowPlayingMovies = decodedResponse.results
            case .popular:
                popularMovies = decodedResponse.results
            case .topRated:
                topRatedMovies = decodedResponse.results
            }
        } catch {
            print("Error fetching movies: \(error)")
        }
    }
}



