//
//  SearchBar.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 20/04/23.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {
    
    let placeholder: String
    @Binding var text: String
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: self.$text)
    }
    
    
    
    class Coordinator: NSObject, UISearchBarDelegate{
        @Binding var text: String
        
        init(text : Binding<String>){
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
    }
}
