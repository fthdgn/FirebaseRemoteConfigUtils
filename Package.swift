// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "FirebaseRemoteConfigUtils",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "FirebaseRemoteConfigUtils", targets: ["FirebaseRemoteConfigUtils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", exact: "509.0.2"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.17.0"),
    ],
    targets: [
        .target(
            name: "FirebaseRemoteConfigUtils",
            dependencies: [
                "FirebaseRemoteConfigUtilsMacros",
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfigSwift", package: "firebase-ios-sdk"),
            ]
        ),
        .macro(
            name: "FirebaseRemoteConfigUtilsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
    ]
)
