//
//  SessionDelegate.swift
//  SwiftSnapshotDownloader
//
//  Created by Sergej Jaskiewicz on 19/01/2017.
//
//

import Foundation

class SessionDelegate: NSObject, URLSessionDownloadDelegate {
    
    private let semaphore: DispatchSemaphore
    private let name: String
    private var date = Date()
    
    init(fileName: String, semaphore: DispatchSemaphore) {
        self.semaphore = semaphore
        name = fileName
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        
        let permanentLocation = downloadFolder.appendingPathComponent(name)
        
        do {
            try FileManager.default.moveItem(at: location,
                                             to: permanentLocation)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        print("File downloaded to \(permanentLocation.path).")
        let installer = Installer(filePath: permanentLocation)
        
        exit(installer.install(semaphore: semaphore))
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        
        if date.timeIntervalSinceNow < -2 {
            print("Downloaded kilobytes: \(totalBytesWritten / 1024) of \(totalBytesExpectedToWrite / 1024).")
            date = Date()
        }
    }
}
