//
//  CategoryView.swift
//  IMDB-Movie-Database
//
//  Created by Abhishek Sharma on 17/07/24.
//

import SwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = MoviesViewModel()
    let category: MovieCategory
    let title: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(moviesForCategory) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieCardView(movie: movie)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            Task {
                await viewModel.fetchMovies(for: category)
            }
        }
        .navigationTitle(title)
    }

    private var moviesForCategory: [Movie] {
        switch category {
        case .trending:
            return viewModel.trendingMovies
        case .nowPlaying:
            return viewModel.nowPlayingMovies
        case .popular:
            return viewModel.popularMovies
        case .topRated:
            return viewModel.topRatedMovies
        }
    }
}
