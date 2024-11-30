//
//  RegisterView.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var registrationMessage: String = ""
    @State private var isError: Bool = false 

    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Username (optional)", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !registrationMessage.isEmpty {
                Text(registrationMessage)
                    .foregroundColor(isError ? .red : .green)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }

            Button(action: {
                viewModel.registerUser { success, message in
                    registrationMessage = message
                    isError = !success
                    if success {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Register")
    }
}
