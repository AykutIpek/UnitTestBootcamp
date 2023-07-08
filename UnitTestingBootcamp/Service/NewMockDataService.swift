//
//  NewMockDataService.swift
//  UnitTestingBootcamp
//
//  Created by aykut ipek on 8.07.2023.
//

import Foundation
import Combine
import SwiftUI

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping(_ items: [String])-> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

final class NewMockDataService: NewDataServiceProtocol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "ONE", "TWO", "THREE"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping(_ items: [String])-> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>{
        Just(items)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}
