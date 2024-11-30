//
//  LoginViewModel.swift
//  LearnConnect-SwiftUI
//
//  Created by Mustafa on 29.11.2024.
//

import CoreData

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    
    func loginUser(completion: @escaping (Bool, String) -> Void) {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                Session.user = user
                completion(true, "Login Successful")
            } else {
                completion(false, "Invalid email or password")
            }
        } catch {
            completion(false, "An error occured during login: \(error.localizedDescription)")
        }
    }
}
