//
//  ContentView.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ArticleListView()
                .tabItem {
                    Label("文章", systemImage: "newspaper")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
