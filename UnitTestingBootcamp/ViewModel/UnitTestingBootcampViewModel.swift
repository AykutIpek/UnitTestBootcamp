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
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
