//
//  LoadingView.swift
//  movie list app
//
//  Created by Gurramgadda Sai Nithin on 19/04/23.
//

import SwiftUI

struct LoadingView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryActions: (() -> ())?
    
    var body: some View {
        Group {
            
            if isLoading {
                
                HStack{
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
                
            } else if error != nil {
                
                HStack{
                    
                    Spacer()
                    VStack{
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryActions != nil {
                            Button(action: self.retryActions!){
                                Text("Retry")
                            }
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer()
                    
                }
                
            }
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: nil, retryActions: nil)
    }
}
