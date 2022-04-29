//
//  MainView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

struct MainView: View {
    var body: some View {
        NavigationView {
            
            VStack{
                Text("Hello there")
            }
            
            navigationTitle("Main Screen")
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
