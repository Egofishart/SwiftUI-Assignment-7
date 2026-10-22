//
//  ContentView.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("იტვირთება პოსტები...")
                } else if let error = viewModel.error {
                    ContentUnavailableView {
                        Label("შეცდომა", systemImage: error.icon)
                    } description: {
                        Text(error.message)
                    } actions: {
                        Button("ხელახლა ცდა") {
                            Task { await viewModel.loadPosts() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(viewModel.posts) { post in
                        NavigationLink(destination: CommentsView(postId: post.id)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(post.title)
                                    .font(.headline)
                                
                                Text(post.body)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("პოსტები")
            .task {
                await viewModel.loadPosts()
            }
        }
    }
}

#Preview {
    ContentView()
}
