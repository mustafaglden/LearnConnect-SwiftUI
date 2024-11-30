//
//  APIService.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//

import Foundation

struct CourseResponse: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let duration: String
    let author: String
    let videoUrl: String
    let videoDescription: String
    let category: String
}

final class APIService {
    static let shared = APIService()
    private init() {}

    private let baseURL = "https://your-api-url.com/api"

    func fetchCourses(completion: @escaping (Result<[CourseResponse], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/courses") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let courses = try JSONDecoder().decode([CourseResponse].self, from: data)
                completion(.success(courses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

