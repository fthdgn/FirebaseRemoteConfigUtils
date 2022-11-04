import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

@propertyWrapper public struct RemoteConfigProperty<T: Decodable> {
    let key: String
    let fallbackValue: T
    
    public var wrappedValue: T {
        do {
            let configValue = RemoteConfig.remoteConfig()[key]
            if configValue.source == .remote || configValue.source == .default {
                return try configValue.decoded()
            } else {
                return fallbackValue
            }
        } catch {
            return fallbackValue
        }
    }
}
