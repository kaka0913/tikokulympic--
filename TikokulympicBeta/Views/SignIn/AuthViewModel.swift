//
//  SignInViewModel.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/10.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Supabase

class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false

    // Googleサインイン
    func signInWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { signInResult, error in
            guard let result = signInResult else {
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                }
                return
            }

            if let idToken = result.user.idToken?.tokenString {
                self.signInToSupabase(withIdToken: idToken)
            } else {
                print("Failed to get idToken from Google Sign-In result.")
            }
        }
    }

    // Supabaseにサインイン
    func signInToSupabase(withIdToken idToken: String) {
        guard let client = SupabaseClientManager.shared.client else {
            print("SupabaseClient is not initialized.")
            return
        }

        Task {
            do {
                let session = try await client.auth.signInWithIdToken(
                    credentials: .init(
                        provider: .google,
                        idToken: idToken
                    )
                )
                self.isSignedIn = true
                print("Supabase Sign-in Success")
                
            } catch {
                print("Supabase Sign-in Error: \(error.localizedDescription)")
            }
        }
    }

    // サインアウトの処理
    func signOut() async {
        GIDSignIn.sharedInstance.signOut()
        guard let client = SupabaseClientManager.shared.client else {
            print("SupabaseClient is not initialized.")
            return
        }
        
        do {
            try await client.auth.signOut()
            isSignedIn = false
            print("Signed out of both Google and Supabase")
        } catch {
            print("Error signing out of Supabase: \(error.localizedDescription)")
        }
    }

    // ルートビューコントローラの取得
    private func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = screen.windows.first?.rootViewController else {
            return UIViewController()
        }
        return root
    }
}
