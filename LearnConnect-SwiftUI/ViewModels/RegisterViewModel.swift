//
//  RegisterViewModel.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//

import CoreData

final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    

    func registerUser(completion: @escaping (Bool, String) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(false, "Email and password cannot be empty.")
            return
        }
        let context = CoreDataStack.shared.context

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                completion(false, "This email is already registered.")
                return
            }

            let newUser = User(context: context)
            newUser.email = email
            newUser.password = password
            newUser.username = username.isEmpty ? email : username

            try context.save()
            completion(true, "Registration successful!")
        } catch {
            completion(false, "Failed to register user: \(error.localizedDescription)")
        }
    }
}

