//
//  CreateProjectView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import SwiftUI

// Add a first step that is setting up steps
struct CreateProjectView: View {
    enum Section: Hashable {
        case title, appearance, endDate
    }
    
    @Namespace private var namespace
    @State private var section = Section.title
    @State private var previousSection = Section.title
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var fontSelection = StudyProject.Appearance.TitleFont.regular
    @State private var color = Color.black
    @State private var symbol = StudyProject.Symbol.book
    @State private var endDate = Date.now
    
    @FocusState private var nameFieldSelected
    
    func titleFontDesign(style: StudyProject.Appearance.TitleFont) -> Font.Design {
        switch style {
        case .rounded: .rounded
        case .serif: .serif
        default: .default
        }
    }
    
    func titleFontWidth(style: StudyProject.Appearance.TitleFont) -> Font.Width {
        switch style {
        case .expanded: .expanded
        default: .standard
        }
    }
    
    var body: some View {
        TabView(selection: $section) {
            Tab(value: .title) {
                VStack {
                    Text("Choose a title for your new Study Project!")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(titleFontDesign(style: fontSelection))
                        .fontWidth(titleFontWidth(style: fontSelection))
                    
                    TextField("Physics Exam…", text: $title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 350)
                        .padding()
                        .background(.glass(shadowRadius: 20), in: .capsule)
                        .padding(.top, 100)
                        .focused($nameFieldSelected)
                        
                }
                .padding()
            }
            
            Tab(value: .appearance) {
                VStack {
                    Text("Tweak the appearance of your Study Project")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(titleFontDesign(style: fontSelection))
                        .fontWidth(titleFontWidth(style: fontSelection))
                    
                    VStack(spacing: 20) {
                        LabeledContent("Font Style:") {
                            HStack {
                                ForEach(StudyProject.Appearance.TitleFont.allCases, id: \.self) { font in
                                    Button {
                                        withAnimation {
                                            fontSelection = font
                                        }
                                    } label: {
                                        Text("Aa")
                                            .font(.title2)
                                            .foregroundStyle(.primary)
                                            .fontDesign(titleFontDesign(style: font))
                                            .fontWidth(titleFontWidth(style: font))
                                            .tag(font)
                                            .padding(8)
                                            .background {
                                                if fontSelection == font {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(.prominentGlass)
                                                        .matchedGeometryEffect(id: "fontBackground", in: namespace)
                                                }
                                            }
                                    }
                                    .buttonStyle(.pressable)
                                }
                            }
                        }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 400)
                        .background(.glass, in: .capsule)
                        
                        ColorPicker("Accent Color:", selection: $color, supportsOpacity: false)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 400)
                            .background(.glass, in: .capsule)
                        
                        LabeledContent("Icon:") {
                            Picker("", selection: $symbol) {
                                ForEach(StudyProject.Symbol.allCases, id: \.self) {
                                    Label($0.displayName, systemImage: $0.rawValue)
                                        .bold()
                                }
                            }
                        }
                        .tint(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 400)
                        .background(.glass, in: .capsule)
                    }
                    .padding(.top, 100)
                }
                .padding()
            }
            
            Tab(value: .endDate) {
                VStack {
                    Text("When is your project due?")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(titleFontDesign(style: fontSelection))
                        .fontWidth(titleFontWidth(style: fontSelection))
                    
                    DatePicker("Due Date:", selection: $endDate, in: Date.now..., displayedComponents: .date)
                        .frame(maxWidth: 350)
                        .padding()
                        .background(.glass, in: .capsule)
                        .padding(.top, 100)
                }
                .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: section) { oldValue, _ in
            previousSection = oldValue
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                if section != .title {
                    Button {
                        switch section {
                        case .appearance:
                            section = .title
                        case .endDate:
                            section = .appearance
                        default:
                            break
                        }
                    } label: {
                            Label("Back", systemImage: "chevron.left")
                                .labelStyle(.iconOnly)
                                .bold()
                                .padding(10)
                                .frame(width: 40)
                        }
                        .buttonBorderShape(.roundedRectangle(radius: 24))
                        .buttonStyle(.prominentGlass)
                    
                    Spacer()
                }
                
                if  title.isEmpty == false {
                    Button {
                        switch section {
                        case .title:
                            section = .appearance
                        case .appearance:
                            section = .endDate
                        case .endDate:
                            createProject()
                            dismiss()
                        }
                    } label: {
                        Text(section == .endDate ? "Create" : "Continue")
                            .font(.headline)
                            .padding(10)
                            .frame(maxWidth: 350)
                    }
                    .buttonBorderShape(.roundedRectangle(radius: 24))
                    .buttonStyle(.prominentGlass)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding()
        }
        .safeAreaInset(edge: .top) {
            Button(action: dismiss.callAsFunction) {
                Label("Home", systemImage: "xmark")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .labelStyle(.iconOnly)
                    .padding(1)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.prominentGlass)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        }
        .animation(.bouncy, value: title.isEmpty)
        .animation(.bouncy, value: section)
        .onChange(of: section) { oldValue, newValue in
            if oldValue == .title {
                guard !title.isEmpty else {
                    section = .title
                    return
                }
                
                nameFieldSelected = false
            } else if newValue == .title {
                nameFieldSelected = true
            }
        }
        .presentationBackground {
            Rectangle()
                .fill(.regularMaterial)
                .colorScheme(.dark)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(color != .black ? AnyShapeStyle(color.gradient.opacity(0.2)) : AnyShapeStyle(.clear))
                .ignoresSafeArea()
            
        }
    }
    
    func createProject() {
        let project = StudyProject(
            title: title,
            appearance: .init(
                titleFont: fontSelection,
                itemColorRepresentation: .init(of: color)
            ),
            symbol: symbol,
            endDate: endDate
        )
        
        let firstStep = StudyProject.Step(
            name: "Add Steps",
            details: "Divide you're project into small, manageable steps."
        )
        
        project.steps.append(firstStep)
        modelContext.insert(project)
    }
}

#Preview {
    CreateProjectView()
        .preferredColorScheme(.dark)
}
