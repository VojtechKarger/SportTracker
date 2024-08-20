import Foundation
import FirebaseAuth

final class AuthManager: AuthManaging {
 
    func isSignedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func createUser(with email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func logIn(with email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}
