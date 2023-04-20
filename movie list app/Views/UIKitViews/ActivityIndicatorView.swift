//
//  ActivityIndicatorView.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 19/04/23.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    func makeUIView(context: Context) ->  UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
}
