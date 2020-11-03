//
//  DataStore.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-03.
//

import Foundation

// MARK: - DiskWriter

protocol DiskWriter {

    static func writeDataToDisk<T: Codable>(data: [T])
}

// MARK: - DiskReader

protocol DiskReader {

    static func readDataFromDisk<T: Codable>() -> [T]
}

// MARK: DataStore

class DataStore {
    private static let fileName = "myFile"
    private static let fileExtension = "json"

    static var fileURL: URL {
        let directoryURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        )[0]

        return URL(
            fileURLWithPath: DataStore.fileName,
            relativeTo: directoryURL
        ).appendingPathExtension(DataStore.fileExtension)
    }
}

// MARK: - DiskWriting

extension DataStore: DiskWriter {

    static func writeDataToDisk<T: Codable>(data: [T]) {
        // Suppress the error for now
        let data = try? JSONEncoder().encode(data)
        try? data?.write(to: fileURL)
    }
}

// MARK: - DiskReading

extension DataStore: DiskReader {

    static func readDataFromDisk<T: Codable>() -> [T] {
        do {
            let savedData = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([T].self, from: savedData)
        } catch {
            return []
        }
    }
}
