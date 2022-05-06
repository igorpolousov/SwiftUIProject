//
//  NewsView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine
struct NewsView: View {
    
    var body: some View {
        VStack {
            Text("Here you'll see news")
            Image("wti")
        }
    }
}

struct NewsView_Preview: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
