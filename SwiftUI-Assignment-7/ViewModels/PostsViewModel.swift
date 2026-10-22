//
//  PostsViewModel.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//
import Foundation
import Combine

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: NetworkError?

    private let service = PostService()

    func loadPosts() async {
        isLoading = true
        error = nil

        do {
            posts = try await service.fetchPosts()
        } catch let networkError as NetworkError {
            error = networkError
        } catch {
            self.error = .noData
        }

        isLoading = false
    }
}
