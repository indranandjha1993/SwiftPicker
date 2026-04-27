// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftPicker",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "SwiftPicker", targets: ["SwiftPicker"])
    ],
    targets: [
        .executableTarget(
            name: "SwiftPicker",
            dependencies: [],
            path: "Sources/SwiftPicker",
            resources: [
                .process("../../Resources/Info.plist")
            ]
        )
    ]
)
