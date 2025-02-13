//
//  SessionDebugView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 13/02/25.
//

import SwiftUI

struct SessionDebugView: View {
    @Bindable var session: StudySession
    
    var colorBinding: Binding<Color> {
        Binding {
            session.appearance.itemColorRepresentation.color
        } set: {
            session.appearance.itemColorRepresentation = ColorRepresentation(of: $0)
        }
    }
    
    var body: some View {
        Form {
            Picker("Font Style", selection: $session.appearance.titleFont) {
                ForEach(StudySession.Appearance.TitleFont.allCases, id: \.self) {
                    Text("\($0)")
                }
            }
            
            ColorPicker("Item Color", selection: colorBinding)
        }
    }
}

//#Preview {
//    SessionDebugView(session: .constant(.example))
//}
