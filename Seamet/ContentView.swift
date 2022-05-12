//
//  ContentView.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Placeholder")
            .onAppear {
                onAppear()
            }
    }
    
    func onAppear() {
        Task {
            try! await ArticleProvider.getArticles()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
