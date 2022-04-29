//
//  SwiftUIProjectApp.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 25.04.2022.
//

import SwiftUI

@main
struct SwiftUIProjectApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(isUserLoggedIn: .constant(false))
        }
    }
}
