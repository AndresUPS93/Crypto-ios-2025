//
//  AssetsApiClient.swift
//  Crypto-iOS
//
//  Created by user271851 on 4/12/25.
//
import Dependencies
import Foundation

struct AssetsApiClient {
    var fetchAllAssets: () async throws -> [Asset]
}

enum NetworkingError: Error {
    case invalidURL
}

extension AssetsApiClient: DependencyKey{
    
    static var liveValue: AssetsApiClient {
        .init(
            fetchAllAssets: {
            let urlSession = URLSession.shared
            
            guard let url = URL(string: "https://2467c6da-aaf8-42cf-a8d7-ff02ba0276f1.mock.pstmn.io/v3/assets") else{
                throw NetworkingError.invalidURL
            }
                let (data, _) = try await urlSession.data(for: URLRequest(url: url))
                let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
                
                return assetsResponse.data
        })		
    }
    
    static var previewValue: AssetsApiClient {
        .init(
            
            fetchAllAssets: {[
                
                .init(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "BTC",
                priceUsd: "84097.1711692464838030",
                changePercent24Hr: "1.3280719336551625"
                ),
                .init(
                id: "ethereum",
                name: "Ethereum",
                symbol: "ETH",
                priceUsd: "1571.4652200624641959",
                changePercent24Hr: "3.2730164164721265"
                ),
                .init(
                id: "tether",
                name: "Tether",
                symbol: "USDT",
                priceUsd: "1.0015108930188691",
                changePercent24Hr: "-0.0811155954143860"
                )
            ]}
            
        
        )
    }
    
    static var testValue: AssetsApiClient{
        .init(fetchAllAssets: {
            reportIssue("AssetsApiClient.fetchAllAssets is unimplemented")
            return []
        })
    }
}

extension DependencyValues {
    var assetsApiClient: AssetsApiClient{
        get { self[AssetsApiClient.self]}
        set { self[AssetsApiClient.self] = newValue }
    }
}

