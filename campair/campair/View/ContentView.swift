//
//  ContentView.swift
//  campair
//
//  Created by Shin Jae Ung on 2022/06/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = DictionaryContentViewModel()
    var body: some View {
        VStack {
            Text("Fighting squerrels!")
                .padding()
            // testcode
            Button("test") {
                viewModel.viewAppeared()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
