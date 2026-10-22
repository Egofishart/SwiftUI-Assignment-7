//
//  CommentsView.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//

import SwiftUI

struct CommentsView: View {
    let postId: Int
    @StateObject private var viewModel = CommentsViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("იტვირთება კომენტარები...")
            } else if let error = viewModel.error {
                ContentUnavailableView {
                    Label("შეცდომა", systemImage: error.icon)
                } description: {
                    Text(error.message)
                } actions: {
                    Button("ხელახლა ცდა") {
                        Task { await viewModel.loadComments(postId: postId) }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List(viewModel.comments) { comment in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(comment.name)
                            .font(.subheadline)
                            .bold()
                        
                        Text(comment.body)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("ავტორი: \(comment.email)")
                            .font(.system(size: 10))
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("კომენტარები")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadComments(postId: postId)
        }
    }
}
