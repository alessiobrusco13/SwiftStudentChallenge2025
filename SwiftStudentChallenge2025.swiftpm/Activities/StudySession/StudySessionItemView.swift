//
//  StudySessionItemView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 10/02/25.
//

import SwiftUI

struct StudySessionItemView: View {
    let session: StudySession
    
    var titleFontDesign: Font.Design {
        switch session.appearance.titleFont {
        case .rounded: .rounded
        case .serif: .serif
        default: .default
        }
    }
    
    var titleFontWidth: Font.Width {
        switch session.appearance.titleFont {
        case .expanded: .expanded
        default: .standard
        }
    }
    
    var itemColor: Color {
        session.appearance.itemColorRepresentation.color
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 36)
                .foregroundStyle(itemColor.gradient)

            Text(session.title)
                .foregroundStyle(itemColor.relativeLuminance > 0.5 ? .black : .white)
                .font(.title)
                .fontWeight(.heavy)
                .fontDesign(titleFontDesign)
                .fontWidth(titleFontWidth)
                .frame(maxWidth: .infinity, maxHeight: . infinity, alignment: .bottomLeading)
                .padding(36)
        }
        .frame(maxWidth: .infinity, maxHeight: 360)
        .padding()
    }
}

#Preview {
    Previewer(for: StudySession.self) {
        StudySessionItemView(session: .example)
    } contextHandler: { context in
        context.insert(StudySession.example)
    }
}
