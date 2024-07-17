//
//  MovieListView.swift
//  IMDB-Movie-Database
//
//  Created by Abhishek Sharma on 12/07/24.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    let title: String

    var body: some View {
        List(movies) { movie in
            HStack {
                AsyncImage(url: URL(string: movie.thumbnailUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 90)
                        .cornerRadius(5)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 90)
                        .cornerRadius(5)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(movie.title)
                        .font(.headline)
                    Text("Rating: \(String(format: "%.1f", movie.rating))")
                        .font(.subheadline)
                    Text("Release Date: \(movie.releaseDate)")
                        .font(.caption)
                }
                Spacer()
            }
        }
        .navigationTitle(title)
    }
}
