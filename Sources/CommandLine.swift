//
//  ArgumentParser.swift
//  SwiftSnapshotDownloader
//
//  Created by Sergej Jaskiewicz on 20/01/2017.
//
//

import Foundation

var KeepDownloadedFile = false

func parseArguments() {
    
    let arguments = CommandLine.arguments
    guard !arguments.isEmpty else {
        return
    }
    
    if arguments.contains("--help") {
        print("USAGE: SwiftSnapshotDownloader [options]\n")
        print("OPTIONS:")
        print("--help\t\t\t\t\t\tDisplay available options")
        print("--keep-downloaded-file\t\tDon't delete the .pkg file")
        
        exit(0)
    }
    
    if arguments.contains("--keep-downloaded-file") {
        KeepDownloadedFile = true
    }
}
