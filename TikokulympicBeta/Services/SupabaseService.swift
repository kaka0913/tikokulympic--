//
//  SupabaseService.swift
//  TikokulympicBeta
//
//  Created by 株丹優一郎 on 2024/09/18.
//

import Foundation
import Supabase

class SupabaseClientManager {
    static let shared = SupabaseClientManager()
    var client: SupabaseClient?

    private init() {
        guard let supabaseURL = APIKeyManager.shared.apiKey(for: "SUPABASE_URL"),
            let supabaseApiKey = APIKeyManager.shared.apiKey(for: "SUPABASE_API_KEY")
        else {
            debugPrint("Supabase URL or API Key not found")
            return
        }

        client = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseApiKey)
        debugPrint("SupabaseClient initialized")
    }

    func getAccessToken() async throws -> String {
        guard let session = try await client?.auth.session else {
            print("トークン取得失敗: ユーザーがサインインしていません")
            throw NSError(
                domain: "SupabaseClientManager", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "No user session found"])
        }
        let accessToken = session.accessToken
        print("アクセストークン取得成功: \(accessToken)")
        return accessToken

    }
}
