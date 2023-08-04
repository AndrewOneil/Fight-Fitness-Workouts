//
//  ModelData.swift
//  Fight-Fitness-Workouts
//
//  Created by Andrew  Oneil on 12/03/2023.
//

import Foundation


var previewVideo: Video = load("videoData.json")

//function will parse JSON data so that swiftui can read and display in in the app, filename is passed in as string
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        //converts API variables from snake case to camel case so that the VideoManagment view can read them
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
