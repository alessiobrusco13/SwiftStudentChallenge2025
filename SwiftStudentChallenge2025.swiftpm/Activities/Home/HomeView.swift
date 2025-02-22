//
//  HomeView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 09/02/25.
//

import SwiftData
import SwiftUI

// – [] Scroll lag when showing welcome message.
// – [] Show 'current' project.

struct HomeView: View {
    @State private var selection: StudyProject?
    @Namespace private var namespace
    
    @Query(filter: HomeView.activeProjectsFilter, sort: \.endDate) private var activeProjects: [StudyProject]
    @Query(filter: HomeView.completedProjectsFilter, sort: \.startDate) private var completedProjects: [StudyProject]
    
    static let activeProjectsFilter = #Predicate<StudyProject> { $0.isCompleted == false }
    static let completedProjectsFilter = #Predicate<StudyProject> { $0.isCompleted }
    
    @AppStorage(Model.currentProjectIDKey) private var currentProjectID: String?
    
    var currentProject: StudyProject? {
        guard
            let currentProjectID,
            let uuid = UUID(uuidString: currentProjectID),
            let project = activeProjects.first(where: { $0.id == uuid })
        else {
            return nil
        }
        
        return project
    }
    
    var otherActiveProjects: [StudyProject] {
        guard let currentProject else {
            return activeProjects
        }
        
        return activeProjects.filter { $0.id != currentProject.id }
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
                        
                        ForEach(activeProjects + completedProjects) { project in
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
                .toolbarVisibility(.hidden, for: .navigationBar)
                .frame(maxWidth: .infinity)
                .topBar { isMinimized in
                    HomeTopBar(isMinimized: isMinimized) {
                        Button {
                        } label: {
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        .buttonBorderShape(.circle)
                        .buttonStyle(.prominentGlass)
                        
                        Button {
                            
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
        .animation(.default, value: otherActiveProjects + completedProjects)
        .fullScreenCover(item: $selection) { project in
            StudyProjectView(project: project)
                .navigationTransition(.zoom(sourceID: project.id, in: namespace))
        }
    }
}

#Preview {
    Previewer(model: .preview) {
        HomeView()
            .environment(Model.preview)
        
    }
}
