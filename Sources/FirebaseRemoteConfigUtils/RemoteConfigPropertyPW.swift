import FirebaseRemoteConfig

@propertyWrapper public struct RemoteConfigPropertyPW<T: Decodable> {
    public let key: String
    public let fallback: T
    
    public init(key: String, fallback: T) {
        self.key = key
        self.fallback = fallback
    }
    
    public var wrappedValue: T {
        return FirebaseRemoteConfig.RemoteConfig.remoteConfig().getValue(forKey: key, withFallback: fallback)
    }
}
