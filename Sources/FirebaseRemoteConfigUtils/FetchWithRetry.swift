import FirebaseRemoteConfig
import Foundation

extension FirebaseRemoteConfig.RemoteConfig {
    enum FetchAndActivateError: Error {
        case fetchStatusNoFetchYet
        case fetchStatusFailure
        case fetchStatusDefault
        case fetchAllTriesFailed
        case activateAllTriesFailed
    }
    
    public func fetchAndActivate(maxRetry: Int) async throws {
        var fetched = false
    loop: for _ in 1 ... maxRetry {
        do {
            try Task.checkCancellation()
            let fetchStatus = try await fetch()
            switch fetchStatus {
            case .noFetchYet:
                throw FetchAndActivateError.fetchStatusNoFetchYet
            case .success:
                fetched = true
                break loop
            case .failure:
                throw FetchAndActivateError.fetchStatusFailure
            case .throttled:
                return
            @unknown default:
                throw FetchAndActivateError.fetchStatusDefault
            }
        } catch {}
    }
        if !fetched {
            throw FetchAndActivateError.fetchAllTriesFailed
        }
        
        for _ in 1 ... maxRetry {
            try Task.checkCancellation()
            do {
                _ = try await activate()
                return
            } catch {}
        }
        
        throw FetchAndActivateError.activateAllTriesFailed
    }
}
