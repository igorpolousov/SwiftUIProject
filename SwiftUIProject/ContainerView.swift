//
//  ContainerView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

struct ContainerView: View {
    @State private var shouldShowMainView: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                LoginView(isUserLoggedIn: $shouldShowMainView)
                
                NavigationLink(destination: MainView(), isActive: $shouldShowMainView) {
                    EmptyView()
                }
                .navigationTitle("Login screen")
            }
        }
    }
}
