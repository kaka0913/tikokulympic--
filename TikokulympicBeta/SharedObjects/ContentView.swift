//
//  ContentView.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/03.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Ranking()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ランキング")
                }

            EventListView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("掲示板")
                }

            TikokuRankingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("プロフィール")
                }
        }
        //AuthView()
    }
}

#Preview {
    ContentView()
}
