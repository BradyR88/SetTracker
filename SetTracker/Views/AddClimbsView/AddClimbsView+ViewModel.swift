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
        private var userSettings: UserSettings = UserSettings.shared
        private let dataController: DataController
        private var showingSheet: Binding<Bool>
        private let gym: Gym
        
        let gradeOptions = 1...14
        
        var gradePickerState: Int = 1
        private(set) var grades: [Int] = []
        var zoneSelection: String = "NoZone"
        var integrationMethod: IntegrationMethod = .add
        var showIntegrationMethod = false
        
        var zones: [String] {
            userSettings.zones
        }
        
        var showContentUnavailableView: Bool {
            grades.isEmpty
        }
        
        //MARK: Initializer
        
        init(modelContext: ModelContext, showingSheet: Binding<Bool>) {
            self.dataController = DataControllerLive(modelContext: modelContext)
            self.showingSheet = showingSheet
            
            let dataFetcher = DataFetcherLive(modelContext: modelContext)
            self.gym = dataFetcher.selectedGym()
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
            let newClimbs = grades.map {
                Climb(
                    grade: Grade(vGrade: $0),
                    gym: gym,
                    zone: zoneSelection
                )
            }
            dataController.add(climbs: newClimbs, integrationMethod: integrationMethod, zones: [zoneSelection])
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
