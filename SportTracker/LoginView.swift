import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: .medium) {
                Text("Login: \(viewModel.email)")
                TextField("username", text: $viewModel.email)
                SecureField("password", text: $viewModel.password)
                
                HStack(spacing: .large) {
                    Button("Sign up", action: viewModel.tapSignUp)
                    Button("Submit", action: viewModel.tapSubmit)
                }
            }
            .frame(maxWidth: 400)
            .padding(.large)
        }
    }
}

#Preview {
    LoginView(viewModel: .init())
}
