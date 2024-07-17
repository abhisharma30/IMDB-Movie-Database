//
//  ContentView.swift
//  IMDB-Movie-Database
//
//  Created by Abhishek Sharma on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MoviesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        SectionView(title: "Trending", movies: viewModel.trendingMovies, category: .trending)
                        SectionView(title: "Now Playing", movies: viewModel.nowPlayingMovies, category: .nowPlaying)
                        SectionView(title: "Popular", movies: viewModel.popularMovies, category: .popular)
                        SectionView(title: "Top Rated", movies: viewModel.topRatedMovies, category: .topRated)
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMovies(for: .trending)
                    await viewModel.fetchMovies(for: .nowPlaying)
                    await viewModel.fetchMovies(for: .popular)
                    await viewModel.fetchMovies(for: .topRated)
                }
            }
            .navigationTitle("Movies")
        }
    }
}

struct SectionView: View {
    let title: String
    let movies: [Movie]
    let category: MovieCategory

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                NavigationLink(destination: CategoryView(category: category, title: title)) {
                    Text("all")
                        .foregroundColor(.blue)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies.prefix(5)) { movie in
                        MovieCardView(movie: movie)
                    }
                }
            }
        }
    }
}

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.thumbnailUrl)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
            }
            HStack {
                Text(String(format: "%.1f", movie.rating))
                    .font(.caption)
                    .bold()
                    .padding(5)
                    .background(Color.green)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                Spacer()
                Text(String(movie.releaseDate.prefix(4)))
                    .font(.caption)
            }
            .padding(.top, 5)
            Text(movie.title)
                .font(.caption)
                .bold()
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

#Preview {
    ContentView()
}
