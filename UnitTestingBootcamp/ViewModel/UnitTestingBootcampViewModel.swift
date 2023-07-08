//
//  UnitTestingBootcampViewModel.swift
//  UnitTestingBootcamp
//
//  Created by aykut ipek on 5.07.2023.
//

import Foundation
import SwiftUI
import Combine


final class UnitTestingBootcampViewModel: ObservableObject{
    //MARK: - Properties
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    var cancellables = Set<AnyCancellable>()
    let dataService: NewDataServiceProtocol
    //MARK: - LifeCycle
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    //MARK: - Enum
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}

//MARK: - Funcs
extension UnitTestingBootcampViewModel{
    func addItem(item: String){
        guard !item.isEmpty else {return}
        self.dataArray.append(item)
    }
    
    func selectedItem(item: String){
        if let x = dataArray.first(where: { $0 == item}){
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item}) {
            print("Save item here")
        }else{
            throw DataError.itemNotFound
        }
    }
    
    func downloadWithEscaping(){
        dataService.downloadItemsWithEscaping {[weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    
    func downloadWithCombine(){
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: {[weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)

    }
}
