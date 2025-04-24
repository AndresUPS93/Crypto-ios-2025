import Foundation
import Dependencies

@Observable
final class AssetListViewModel {
    
    var errorMessage: String?
    var assets: [Asset] = []
    
    
    @ObservationIgnored
    @Dependency(\.assetsApiClient) var apiClient
    
    func fetchAssets() async {
        
                
        do {
            
            assets = try await apiClient.fetchAllAssets()
            
            
        } catch let error as NetworkingError {
            errorMessage = error.localizedDescription
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
}


