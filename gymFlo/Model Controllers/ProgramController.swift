//
//  ProgramController.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class ProgramController: ObservableObject {
    
    // MARK: - Shared Instance
    static let shared = ProgramController()

    // MARK: - Source of Truth
    @Published var programs: [Program] = []
    
    init() {
        loadFromPersistenceStore()
    }
    
    // MARK: - Programs
    func createProgramWith(newName: String) {
        let newProgram = Program(name: newName)
        programs.append(newProgram)
        saveToPersistenceStore()
    }
    
    func deleteProgram(at indexSet: IndexSet) {
        programs.remove(atOffsets: indexSet)
        saveToPersistenceStore()
    }
    
    // MARK: - Routines
    func addRoutineTo(program: Program, routine: Routine) {
        program.routines.append(routine)
        saveToPersistenceStore()
    }
    
    
    func removeRoutineFrom(program: Program, routine: Routine) {
        guard let index = program.routines.firstIndex(of: routine) else { return }
        program.routines.remove(at: index)
        saveToPersistenceStore()
    }
    
    
    // MARK: - Data Persistence
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Program.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(programs)
            try data.write(to: fileURL())
            print("File saved to\(data)")
        } catch {
            print(error)
            print("There was an error encoding \(error.localizedDescription)")
        }
    }
    
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let foundPrograms = try JSONDecoder().decode([Program].self, from: data)
            programs = foundPrograms
        } catch {
            print(error)
            print("There was an error decoding the data: \(error.localizedDescription)")
        }
    }
}
