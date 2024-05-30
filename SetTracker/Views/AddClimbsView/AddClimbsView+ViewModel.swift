//
//  AddClimbsViewModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/15/24.
//

import SwiftData
import Foundation
import SwiftUI

extension AddClimbsView {
    @Observable
    final class ViewModel {
        
        //MARK: State
        
        private let modelContext: ModelContext
        private var showingSheet: Binding<Bool>
        
        let gradeOptions = 1...14
        let zones = ["Zone 1", "Zone 2", "Zone 3"]
        
        var gradePickerState: Int = 1
        private(set) var grades: [Int] = []
        var zoneSelection: String = "NoZone"
        var integrationMethod: IntegrationMethod = .add
        var showIntegrationMethod = false
        
        var showContentUnavailableView: Bool {
            grades.isEmpty
        }
        
        //MARK: Initializer
        
        init(modelContext: ModelContext, showingSheet: Binding<Bool>) {
            self.modelContext = modelContext
            self.showingSheet = showingSheet
        }
        
        //MARK: Actions
        
        func add() {
            self.add(grade: gradePickerState)
        }
        
        func autoPopulate() {
            let newGrade = Int.random(in: 1...14)
            self.add(grade: newGrade)
        }
        
        func editGrade() {
            
        }
        
        func submit() {
            for grade in grades {
                let newClimb = Climb(grade: grade)
                modelContext.insert(newClimb)
            }
            showingSheet.wrappedValue = false
        }
        
        func deleteGrade(at offsets: IndexSet) {
            grades.remove(atOffsets: offsets)
        }
        
        //MARK: Private Functions
        
        private func add(grade: Int) {
            withAnimation {
                grades.append(grade)
                grades.sort()
            }
        }
        
        //MARK: Binding Update Funtions
        
        func updateZoneSelection(to newValue: String) {
            zoneSelection = newValue
            
            if zoneSelection != "NoZone" && zoneSelection != "NewZone" {
                withAnimation {
                    showIntegrationMethod = true
                }
            } else {
                withAnimation {
                    showIntegrationMethod = false
                }
            }
        }
    }
}
