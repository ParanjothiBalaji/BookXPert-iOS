//
//  PDFService.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import Foundation

class PDFService {

    static let shared = PDFService()

    private init() {}

    func fetchPDFData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Unknown PDF Error", code: -1)))
            }
        }.resume()
    }
}
