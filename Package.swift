import PackageDescription

let package = Package(
    name: "SwiftSnapshotDownloader",
    dependencies: [
    	.Package(url: "https://github.com/WeirdMath/Scrape.git", majorVersion: 1)
    ]
)
