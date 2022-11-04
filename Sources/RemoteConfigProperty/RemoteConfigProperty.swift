import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

@propertyWrapper public struct RemoteConfigProperty<T: Decodable> {
    public let key: String
    public let fallbackValue: T
    
    public init(key: String, fallbackValue: T) {
        self.key = key
        self.fallbackValue = fallbackValue
    }
    
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
