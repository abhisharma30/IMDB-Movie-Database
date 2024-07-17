//
//  MovieDetailView.swift
//  IMDB-Movie-Database
//
//  Created by Abhishek Sharma on 17/07/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.thumbnailUrl)")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 200)
                .cornerRadius(8)

                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                
                Text("Directed by Frank Darabont") // Placeholder for director's name
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("Released in \(String(movie.releaseDate.prefix(4)))")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("A brief description of the movie would go here. For now, it's just placeholder text.")
                    .font(.body)
                
                HStack {
                    Text("Rating: \(String(format: "%.1f", movie.rating))")
                    Spacer()
                    Text("Runtime: 142 min") // Placeholder for runtime
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Text("Actors: Tim Robbins, Morgan Freeman") // Placeholder for actors
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Link("Watch Trailer", destination: URL(string: "https://www.youtube.com/watch?v=NmzuHjWmXOc")!) // Placeholder trailer URL
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Link("Visit Website", destination: URL(string: "https://www.imdb.com/title/tt0111161/")!) // Placeholder website URL
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

