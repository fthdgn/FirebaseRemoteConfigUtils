// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "FirebaseRemoteConfigUtils",
    platforms: [
        .iOS(.v13)],
    products: [
        .library(name: "FirebaseRemoteConfigUtils", targets: ["FirebaseRemoteConfigUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0"),
    ],
    targets: [
        .target(
            name: "FirebaseRemoteConfigUtils",
            dependencies: [
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfigSwift", package: "firebase-ios-sdk"),
            ]
        ),
    ]
)
