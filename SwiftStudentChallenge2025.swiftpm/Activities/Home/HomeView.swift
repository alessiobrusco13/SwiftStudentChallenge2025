//
//  HomeView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftData
import SwiftUI

// – [] Scroll lag when showing welcome message.
// – [X] Show 'current' project.

struct HomeView: View {
    @State private var selection: StudyProject?
    @State private var creatingProject = false
    @Namespace private var namespace
    
    @Query var projects: [StudyProject]
    @State private var showingCitations = false
    
    // Active project means that it has a currently running study session in it. When there is an active project the user cannot access any of the other projects
    @AppStorage(Model.activeProjectIDKey) private var activeProjectID: String?
    
    // Uncompleted projects come first.
    // Sort completed projects by latest endDate and uncompleted projects by earliest endDate.
    var sortedProjects: [StudyProject] {
        projects.sorted {
            if $0.isCompleted == $1.isCompleted {
                if $0.isCompleted {
                    return $0.endDate > $1.endDate
                } else {
                    return $0.endDate < $1.endDate
                }
            }
            return !$0.isCompleted
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedBackgroundView()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        //                        if let currentProject {
                        //                            StudyProjectItemView(project: currentProject)
                        //                        }
                        
                        if let activeProjectID = UUID(uuidString: activeProjectID ?? ""),
                           let activeProject = sortedProjects.first(where: { $0.id == activeProjectID }) {
                            Text("This is the only project you can see right now, stay focused!")
                                .multilineTextAlignment(.center)
                                .font(.title3.bold())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.glass, in: .rect(cornerRadius: 30))
                                .padding()
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                            
                            Button {
                                selection = activeProject
                            } label: {
                                StudyProjectItemView(project: activeProject, namespace: namespace)
                                    .shadow(color: .black.opacity(0.1), radius: 10)
                            }
                            .buttonStyle(.pressable)
                            .padding(.horizontal)
                        } else {
                                ForEach(sortedProjects) { project in
                                    Button {
                                        selection = project
                                    } label: {
                                        StudyProjectItemView(project: project, namespace: namespace)
                                            .shadow(color: .black.opacity(0.1), radius: 10)
                                    }
                                    .buttonStyle(.pressable)
                                    .padding(.horizontal)
                                }
                        }
                    }
                }
                .toolbarVisibility(.hidden, for: .navigationBar)
                .frame(maxWidth: .infinity)
                .topBar(behavior: activeProjectID == nil ? .standard : .neverMinimized) { isMinimized in
                    HomeTopBar(isMinimized: isMinimized) {
                        Button {
                            creatingProject = true
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        .buttonBorderShape(.circle)
                        .buttonStyle(.prominentGlass)
                        
                        Button {
                            showingCitations.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        .buttonBorderShape(.circle)
                        .buttonStyle(.glass)
                    }
                }
            }
        }
        .animation(.default, value: sortedProjects)
        .fullScreenCover(item: $selection) { project in
            StudyProjectView(project: project)
                .navigationTransition(.zoom(sourceID: project.id, in: namespace))
        }
        .fullScreenCover(isPresented: $creatingProject, content: CreateProjectView.init)
        .sheet(isPresented: $showingCitations, content: CitationsView.init)
    }
}

#Preview {
    Previewer(model: .preview) {
        HomeView()
            .environment(Model.preview)
        
    }
}
