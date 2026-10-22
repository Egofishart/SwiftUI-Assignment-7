//
//  Network.swift
//  SwiftUI-Assignment-7
//
//  Created by NikoDanelia on 22/10/2026.
//

import Foundation

struct PostService {
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw NetworkError.invalidURL
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.noInternet
        } catch {
            throw NetworkError.noData
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.badStatusCode(code)
        }

        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }

    func fetchComments(postId: Int) async throws -> [Comment] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            throw NetworkError.invalidURL
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.noInternet
        } catch {
            throw NetworkError.noData
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.badStatusCode(code)
        }

        do {
            return try JSONDecoder().decode([Comment].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
