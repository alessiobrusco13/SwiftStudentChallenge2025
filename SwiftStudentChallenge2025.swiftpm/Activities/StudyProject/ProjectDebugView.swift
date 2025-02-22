//
//  ProjectDebugView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

struct ProjectDebugView: View {
    @Bindable var project: StudyProject
    
    var colorBinding: Binding<Color> {
        Binding {
            project.appearance.itemColorRepresentation.color
        } set: {
            project.appearance.itemColorRepresentation = ColorRepresentation(of: $0)
        }
    }
    
    var body: some View {
        Form {
            Picker("Font Style", selection: $project.appearance.titleFont) {
                ForEach(StudyProject.Appearance.TitleFont.allCases, id: \.self) {
                    Text("\($0)")
                }
            }
            
            ColorPicker("Item Color", selection: colorBinding)
            
            Picker("Symbol", selection: $project.symbol) {
                ForEach(StudyProject.Symbol.allCases, id: \.self) {
                    Label($0.rawValue, systemImage: $0.rawValue)
                        .tag($0)
                }
            }
        }
    }
}
