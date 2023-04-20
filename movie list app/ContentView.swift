//
//  ContentView.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 20/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    VStack{
                        Image(systemName: "tv")
                        Text("Home")
                    }
                }
                .tag(0)
            MovieSearchView()
                .tabItem {
                    VStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
