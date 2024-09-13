//
//  AddClimbsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/15/24.
//

import SwiftData
import SwiftUI

struct AddClimbsView: View {
    @Bindable var viewModel: ViewModel
    
    init(modelContext: ModelContext, showingSheet: Binding<Bool>) {
        self.viewModel = ViewModel(modelContext: modelContext, showingSheet: showingSheet)
    }
    
    var body: some View {
        VStack {
            self.gradeList
            self.userInput
        }
    }
    
    //MARK: Sub-Views Grade List
    
    @ViewBuilder
    private var gradeList: some View {
        if viewModel.showContentUnavailableView {
            ContentUnavailableView("No Climbs", systemImage: "figure.climbing", description: nil)
        } else {
            List {
                ForEach(viewModel.grades, id: \.self) { grade in
                    Button {
                        viewModel.editGrade()
                    } label: {
                        Text("V" + String(grade))
                    }
                }
                .onDelete(perform: viewModel.deleteGrade)
            }
        }
    }
    
    //MARK: Sub-Views User Input
    
    private var userInput: some View {
        VStack {
            self.zonePicker
            if self.viewModel.showIntegrationMethod {
                self.integrationPicker
            }
            self.gradePicker
            self.buttonBar
        }
        .padding(.horizontal)
    }
    
    private var zonePicker: some View {
        Picker("Zone", selection:
                Binding(get: {viewModel.zoneSelection}, set: { viewModel.updateZoneSelection(to: $0)})
        ) {
            Text("No Zone")
                .tag("NoZone")
            ForEach(viewModel.zones, id: \.self) { zone in
                Text(String(zone))
                    .tag(zone)
            }
            Text("New Zone")
                .tag("NewZone")
        }
        .pickerStyle(.menu)
    }
    
    private var integrationPicker: some View {
        Picker("Replace or Add", selection: $viewModel.integrationMethod) {
            ForEach(IntegrationMethod.allCases, id: \.self) { method in
                Text(method.rawValue.capitalized)
                    .tag(method)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    private var gradePicker: some View {
        Picker("Grade", selection:
                Binding(get: {viewModel.gradePickerState}, set: { viewModel.gradePickerState = $0})
        ) {
            ForEach(viewModel.gradeOptions, id: \.self) { grade in
                Text("V" + String(grade))
                    .tag(grade)
            }
            
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    private var buttonBar: some View {
        VStack {
            HStack {
                Button("auto") {
                    viewModel.autoPopulate()
                }
                Button("submit") {
                    viewModel.submit()
                }
            }
            
            Button("Add Grade", systemImage: "plus.circle") {
                viewModel.add()
            }
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        let modelContext = container.mainContext
        
        //let example = Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"))
        return AddClimbsView(modelContext: modelContext, showingSheet: .constant(true))
    } catch {
        fatalError("Failed to create model container.")
    }
}
