import Darwin.C
import Foundation

// So the program doesn't exit before the toolchain is downloaded and installed
let semaphore = DispatchSemaphore(value: 0)

var downloadFolder = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

parseArguments()

guard let parser = HTMLParser() else {
    print("Could not access swift.org")
    exit(1)
}

guard let downloadURL = parser.getDownloadURL() else {
    print("Could not parse swift.org")
    exit(1)
}

let filePath = downloadFolder.appendingPathComponent(downloadURL.lastPathComponent)

if FileManager
    .default
    .fileExists(atPath: filePath.path) {
    
    let installer = Installer(filePath: filePath)
    exit(installer.install(semaphore: semaphore))
}

let delegate = SessionDelegate(fileName: downloadURL.lastPathComponent, semaphore: semaphore)
let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
let task = session.downloadTask(with: downloadURL)

print("Downloading file \(downloadURL.absoluteString)...")
task.resume()
_ = semaphore.wait(timeout: .distantFuture)
