//
//  CommentsViewModel.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//

import Foundation
import Combine

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var isLoading = false
    @Published var error: NetworkError?

    private let service = PostService()

    func loadComments(postId: Int) async {
        isLoading = true
        error = nil

        do {
            comments = try await service.fetchComments(postId: postId)
        } catch let networkError as NetworkError {
            error = networkError
        } catch {
            self.error = .noData
        }

        isLoading = false
    }
}
