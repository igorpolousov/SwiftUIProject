//
//  MainView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import SwiftUI
import Combine

class Friend:Identifiable {
    
    let id: UUID = UUID()
    let firstName: String
    let secondName: String
    
    internal init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
    }
}

struct MainView: View {
    
    @State private var friends: [Friend] = [
    Friend(firstName: "Гена", secondName: "Крокодил"),
    Friend(firstName: "Чебурашка", secondName: "Знатный"),
    Friend(firstName: "Шапокляк", secondName: "Обыкновенный")
    ]
    
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
