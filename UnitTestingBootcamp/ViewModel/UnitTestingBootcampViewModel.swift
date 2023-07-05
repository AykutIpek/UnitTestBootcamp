//
//  UnitTestingBootcampViewModel.swift
//  UnitTestingBootcamp
//
//  Created by aykut ipek on 5.07.2023.
//

import Foundation
import SwiftUI


final class UnitTestingBootcampViewModel: ObservableObject{
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
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
}
