//
//  Installer.swift
//  SwiftSnapshotDownloader
//
//  Created by Sergej Jaskiewicz on 19/01/2017.
//
//

import Foundation

class Installer {
    
    private var filePath: URL
    
    init(filePath: URL) {
        self.filePath = filePath
    }
    
    func install(semaphore: DispatchSemaphore) -> Int32 {
        
        let installationProcess = Process()
        installationProcess.launchPath = "/usr/sbin/installer"
        installationProcess.arguments = ["-pkg", filePath.path, "-tgt", "/"]
        let pipe = Pipe()
        installationProcess.standardOutput = pipe
        installationProcess.standardError = pipe
        
        var stdoutObserver: NSObjectProtocol!
        stdoutObserver =
            NotificationCenter
                .default
                .addObserver(forName: .NSFileHandleDataAvailable,
                             object: pipe.fileHandleForReading,
                             queue: nil) { _ in
                                
                                let data = pipe.fileHandleForReading.availableData
                                if !data.isEmpty, let output = String(data: data, encoding: .utf8) {
                                    print(output)
                                    pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
                                } else {
                                    NotificationCenter.default.removeObserver(stdoutObserver)
                                }
        }
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        print("Installing...")
        installationProcess.launch()
        installationProcess.waitUntilExit()
        semaphore.signal()
        
        if installationProcess.terminationStatus == 0 {
            removeDownloadedFileIfNeeded()
        }
        
        return installationProcess.terminationStatus
    }
    
    private func removeDownloadedFileIfNeeded() {
       
        if KeepDownloadedFile { return }
        
        print("Deleting \(filePath.path)...")
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
