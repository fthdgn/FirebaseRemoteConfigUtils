import FirebaseRemoteConfig

public extension FirebaseRemoteConfig.RemoteConfig {
    func getValue<T: Decodable>(forKey key: String, withFallback fallback: T) -> T {
        do {
            let configValue = RemoteConfig.remoteConfig()[key]
            if configValue.source == .remote || configValue.source == .default {
                return try configValue.decoded()
            } else {
                return fallback
            }
        } catch {
            return fallback
        }
    }
}
