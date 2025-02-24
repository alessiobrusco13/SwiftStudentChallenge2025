//
//  OnboardingView.swift
//  SwiftStudentChallenge2025
//
//  Created by Alessio Garzia Marotta Brusco on 24/02/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = OnboardingStep.welcome
    @State private var buttonShowing = false
    @State private var welcomeTextShowing = false
    
    @State private var showingProcrastinationText = false
    
    @AppStorage(Model.hasOnboardedKey) private var hasOnboarded = false
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
                .ignoresSafeArea()
            
            
            TabView(selection: $currentStep) {
                Tab(value: .welcome) {
                    if welcomeTextShowing {
                        VStack {
                            Text("Welcome to")
                                .font(.title.weight(.semibold))
                                .foregroundStyle(.secondary)
                            
                            Text("Lucid")
                                .font(.system(size: 90, weight: .heavy))
                            
                            
                            Text("Your new study Environment")
                                .font(.title.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                }
                
                Tab(value: .procrastination) {
                    Text("Did you know that procrastination is actually not your fault?")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .task {
                            Task { @MainActor in
                                try? await Task.sleep(for: .seconds(0.6))
                                withAnimation {
                                    showingProcrastinationText = true
                                }
                            }
                        }
                    
                    if showingProcrastinationText {
                        Text("Procrastination is caused by a physiological bias that makes us prioritize immediate pleasure over hard-earned long-term goals.")
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .padding()
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                
                Tab(value: .emotions) {
                    Text("Studies show that you procrastinate when you don't manage your emotions properly or fall into anxiety!")
                        .font(.title.bold())
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                Tab(value: .projectsAndSteps) {
                    ZStack {
                        StudyProjectItemView(project: .example, namespace: namespace)
                            .offset(x: 10, y: -200)
                            .scaleEffect(0.8)
                        
                        VStack {
                            Text("Lucid crates the perfect study environment, where anxiety is minimzed and mindfulness is encouraged.")
                                .font(.title.bold())
                                .padding()
                                .multilineTextAlignment(.center)
                                .offset(x: 0, y: 150)
                            
                        }
                    }
                }
                
                Tab(value: .session) {
                    VStack {
                        StudySessionView(project: .example, session: .example)
                            .environment(Model.preview)
                        
                        StepsView(project: .example, selection: .constant(nil), showingAllSteps: .constant(false))
                        
                        Text("Start Study Sessions inside the app, focusing on a step-by-step approach, reducing stress!")
                            .font(.title2.bold())
                            .padding()
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }
                }
                
                Tab(value: .mindfulness) {
                    VStack {
                        Text("Focus on what you feel while studying and manage your emotions!")
                            .font(.title2.bold())
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        EmotionLogView(project: .example)
                            .padding()
                            .background(.glass, in: .rect(cornerRadius: 24))
                            .environment(Model.preview)
                    }
                }
                
                Tab(value: .recommendations) {
                    VStack {
                        Spacer()
                        
                        Text("⚠️Recommendations⚠️")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Text("Please run on the iPhone simulator, the app isn't yet optimized for iPad.")
                        
                        Text("The papers I consulted are in the settings tap of the home screen.")
                        
                        Spacer()
                        
                        Text("Made with ❤️ by Alessio Garzia Marotta Brusco")
                            .font(.headline)
                        
                        Spacer()
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                }
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .animation(.default, value: currentStep)
        .task {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.4))
                withAnimation {
                    welcomeTextShowing = true
                }
                
                try? await Task.sleep(for: .seconds(0.6))
                withAnimation {
                    buttonShowing = true
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            if buttonShowing {
                Button {
                    incrementStep()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .padding(10)
                        .frame(maxWidth: 350)
                }
                .buttonBorderShape(.roundedRectangle(radius: 24))
                .buttonStyle(.prominentGlass)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
    
    func incrementStep() {
        switch currentStep {
        case .welcome:
            currentStep = .procrastination
        case .procrastination:
            currentStep = .emotions
        case .emotions:
            currentStep = .projectsAndSteps
        case .projectsAndSteps:
            currentStep = .session
        case .session:
            currentStep = .mindfulness
        case .mindfulness:
            currentStep = .recommendations
        case .recommendations:
            withAnimation {
                hasOnboarded = true
            }
        }
    }
}

#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
