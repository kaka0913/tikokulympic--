//
//  AuthView.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/10.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        VStack {
            if viewModel.isSignedIn {
                Text("Signed in successfully!")
                    .font(.title)
                    .padding()
            } else {
                Text("Sign in with Google")
                    .font(.title)
                    .padding()

                GoogleSignInButton {
                    viewModel.signInWithGoogle()
                }
                .frame(width: 220, height: 50)
                .padding()
            }
        }
    }
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
