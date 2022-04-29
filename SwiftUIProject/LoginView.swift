//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 25.04.2022.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    @State private var showIncorrectCredentialsWarning = false
    @Binding var isUserLoggedIn: Bool
    
    
    // from Combime properties
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map {_ in true},
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map {_ in false}
    )
        .removeDuplicates()
    
    private func verifyLoginData() {
        if login == "Login" && password == "1" {
            isUserLoggedIn = true
        } else {
            showIncorrectCredentialsWarning = true
        }
        password = ""
    }
    
    var body: some View {
        
        // Zstack contains ( background image -> scrollView
        // scrollView contains ( VStack with Logo -> VStack contains  (HStack Login + HStack Password fields) -> Login Button))
        
        ZStack{
            GeometryReader { _ in
                Image("swift-og")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if shouldShowLogo {
                        Text("VK App SwiftUI")
                            .font(.largeTitle)
                            .padding(.top, 32)
                    }
                    // Login Password fields
                    VStack {
                        HStack{
                            Text("Login:")
                            Spacer()
                            TextField("",text: $login)
                                .frame(maxWidth: 150)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Password:")
                            Spacer()
                            SecureField("", text: $password)
                                .frame(maxWidth: 150)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                }.frame(maxWidth: 250)
                    .padding(.top, 50)
                
                // Login button
                Button(action: verifyLoginData) {
                    Text("Login")
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                .disabled(login.isEmpty || password.isEmpty)
            }
        }
        .onReceive(keyboardIsOnPublisher) { isKeyBoardOn in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.shouldShowLogo = !isKeyBoardOn
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .alert(isPresented: $showIncorrectCredentialsWarning) {
            Alert(title: Text("Error"), message: Text("Incorrect login/password was entered"))
        }
    }
}
        
struct LoginView_Previews: PreviewProvider {
   
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
    }
}

struct ContainerView: View {
    @State private var shouldShowMainView: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                LoginView(isUserLoggedIn: $shouldShowMainView)
                
                NavigationLink(destination: MainView(), isActive: $shouldShowMainView) {
                    EmptyView()
                }
                .navigationTitle("Main screen")
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
