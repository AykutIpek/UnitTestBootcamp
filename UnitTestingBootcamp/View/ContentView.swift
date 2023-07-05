//
//  ContentView.swift
//  UnitTestingBootcamp
//
//  Created by aykut ipek on 5.07.2023.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.isPremium.description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isPremium: true)
    }
}
