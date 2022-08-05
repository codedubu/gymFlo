//
//  ProgramController.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class ProgramController {
    
    // MARK: - Shared Instance
    static let shared = ProgramController()

    // MARK: - Source of Truth
    var programs: [Program] = []
    
    // MARK: - CRUD Methods
    // Programs
    func createProgramWith(newName: String) {
        let newProgram = Program(name: newName)
        programs.append(newProgram)
    }
    
    
    func delete(programToDelete: Program) {
        guard let index = programs.firstIndex(of: programToDelete) else { return }
        programs.remove(at: index)
        saveToPersistenceStore()
    }
    
    
    // Routines
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
