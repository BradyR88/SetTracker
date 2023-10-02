//
//  ClimbEditSheet.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/21/23.
//

import SwiftUI
import SwiftData

struct ClimbEditSheet: View {
    @Bindable var climb: Climb
    let onDone: () -> Void
    
    @State var expandedForm = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    onDone()
                }
                .padding(.trailing)
                .buttonStyle(.bordered)
            }
            
            Form {
                Section("Grade") {
                    HorizontalPicker($climb.grade, items: [0,1,2,3,4,5,6,7,8,9,10,11,12,13]) { grade in
                        GeometryReader { reader in
                            Text("V\(grade)")
                                .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        }
                    }
                }
                
                Section("Hold Color") {
                    ColorPicker(holdColor: $climb.color)
                }
                
                TextField("Setter", text: $climb.setter)
                    .submitLabel(.done)
                
                // leaving because it might be useful pending on how I implement color blind mode
//                Picker("Color", selection: $climb.color) {
//                    Text("No Color").tag(nil as HoldColors?)
//                    ForEach(HoldColors.allCases) { color in
//                        Text(color.rawValue).tag(color as HoldColors?)
//                    }
//                }
                MultiPicker(text: "Add climb style", selectedItems: $climb.style)
                
                Section(isExpanded: $expandedForm) {
                    DatePicker("Date Set", selection: $climb.safeDateUp, displayedComponents: .date)
                } header: {
                    HStack{
                        Text("Other")
                        Spacer()
                        Button {
                            expandedForm.toggle()
                        } label: {
                            Image(systemName: expandedForm ? "chevron.down" : "chevron.right")
                        }

                    }
                }
                
                Section {
                    if climb.state == .inProgress {
                        Button("Done Setting") {
                            onDone()
                            climb.state = .up
                        }
                        .frame(maxWidth: .infinity)
                        .tint(.green)
                    } else if climb.state == .up {
                        Button("Setting") {
                            withAnimation {
                                climb.state = .inProgress
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .tint(.orange)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)

        let example = Climb(grade: 4)
        return ClimbEditSheet(climb: example, onDone: {
            // N/A
        })
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
