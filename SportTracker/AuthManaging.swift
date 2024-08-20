
protocol AuthManaging {
    
    func isSignedIn() -> Bool
    func createUser(with email: String, password: String) async throws
    func logIn(with email: String, password: String) async throws
    func signOut() throws
}
