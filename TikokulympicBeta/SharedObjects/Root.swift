//
//  Root.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/07.
//

import SwiftUI

struct Root: View {

    @ObservedObject private var router = Router()

    var body: some View {
        switch router.route.current {
        case .splash:
            SplashView(viewModel: SplashViewModel(router: router))
        case .login:
            LoginView(viewModel: LoginViewModel(router: router))
        case .tab:
            MainTabView()
        }
    }

}
