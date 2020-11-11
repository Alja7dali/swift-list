// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "List",
  products: [
    .library(name: "List", targets: ["List"]),
  ],
  targets: [
    .target(name: "List", dependencies: []),
    .testTarget(name: "ListTests", dependencies: ["List"]),
  ]
)
