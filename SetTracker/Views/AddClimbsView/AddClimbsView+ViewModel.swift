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
        private(set) var newClimbs: [NewClimbsModel] = []
        var zoneSelection: String = "No Zone"
        var setterSelection: String = "No Setter"
        var integrationMethod: IntegrationMethod = .add
        var showIntegrationMethod = false
        
        var zones: [String] {
            userSettings.zones
        }
        
        var setters: [String] {
            userSettings.setters
        }
        
        var showContentUnavailableView: Bool {
            newClimbs.isEmpty
        }
        
        var showSetterPicker: Bool {
            !setters.isEmpty
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
            let climbs = newClimbs.mapClimbs(gym: self.gym, zone: self.zoneSelection)
            dataController.add(climbs: climbs, integrationMethod: integrationMethod, zones: [zoneSelection])
            showingSheet.wrappedValue = false
        }
        
        func deleteGrade(at offsets: IndexSet) {
            newClimbs.remove(atOffsets: offsets)
        }
        
        //MARK: Private Functions
        
        private func add(grade: Int) {
            let nullableSetterName: String?
            if setterSelection == "No Setter" {
                nullableSetterName = nil
            } else {
                nullableSetterName = setterSelection
            }
            withAnimation {
                newClimbs.append(NewClimbsModel(grade: grade, setter: nullableSetterName) )
                newClimbs.sort()
            }
        }
        
        //MARK: Binding Update Funtions
        
        func updateZoneSelection(to newValue: String) {
            zoneSelection = newValue
            
            if zoneSelection != "No Zone" && zoneSelection != "NewZone" {
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
