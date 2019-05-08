// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AlgebraFx",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "AlgebraFx", targets: ["AlgebraFx"]),
    .library(name: "AlgebraRxSwift", targets: ["AlgebraRxSwift"]),
    .library(name: "AlgebraRxCocoa", targets: ["AlgebraRxCocoa"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/myste1tainn/SwiftExpansion.git", from: "0.1.0"),
    
    .package(url: "https://github.com/myste1tainn/RxSwiftExpansion.git", from: "0.1.0"),
    
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.3.1"),
    
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(name: "AlgebraFx", dependencies: ["SwiftExpansion"]),
    .testTarget(name: "AlgebraFxTests", dependencies: ["AlgebraFx"]),
    
    .target(name: "AlgebraRxSwift", dependencies: ["AlgebraFx", "RxSwift", "RxSwiftExpansion"]),
    .testTarget(name: "AlgebraRxSwiftTests", dependencies: ["AlgebraRxSwift"]),
    
    .target(name: "AlgebraRxCocoa", dependencies: ["AlgebraRxSwift", "RxCocoa", "RxCocoaExpansion"]),
    .testTarget(name: "AlgebraRxCocoaTests", dependencies: ["AlgebraRxCocoa"]),
  ]
)
