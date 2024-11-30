//
//  LoginView.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var navigateToRegister: Bool = false
    @State private var navigateToTabbar: Bool = false
    @State private var loginError: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(alignment: .center)

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    viewModel.loginUser { success, message in
                        if success {
                            navigateToTabbar = true
                        } else {
                            navigateToTabbar = false
                            loginError = message
                        }
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink("Register", destination: RegisterView())
                    .foregroundColor(.blue)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Text("LOGIN").font(.headline)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $navigateToTabbar) {
            MainTabBarView()
        }
    }
}
