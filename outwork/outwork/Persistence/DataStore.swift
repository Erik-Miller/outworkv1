//
//  DataStore.swift
//  outwork
//
//  Created by Chris Feher on 2020-11-03.
//

import Foundation

// MARK: - DiskWriter

protocol DiskWriter {

    associatedtype T: Codable

    static func writeDataToDisk(data: [T])
}

// MARK: - DiskReader

protocol DiskReader {

    associatedtype T: Codable

    static func readDataFromDisk() -> [T]
}

// MARK: DataStore

class DataStore<T: Codable> {

    static var fileURL: URL {
        let directoryURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        )[0]

        return URL(
            fileURLWithPath: "\(T.self)",
            relativeTo: directoryURL
        ).appendingPathExtension("json")
    }
}

// MARK: - DiskWriting

extension DataStore: DiskWriter {

    static func writeDataToDisk(data: [T]) {
        // Suppress the error for now
        let data = try? JSONEncoder().encode(data)
        try? data?.write(to: fileURL)
    }
}

// MARK: - DiskReading

extension DataStore: DiskReader {

    static func readDataFromDisk() -> [T] {
        do {
            let savedData = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([T].self, from: savedData)
        } catch {
            return []
        }
    }
}
