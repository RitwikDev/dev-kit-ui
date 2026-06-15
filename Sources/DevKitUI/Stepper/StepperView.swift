//
//  StepperView.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

public struct StepperView<Content: View>: View {
    @Binding public var currentStepId: Int
    public var onNavigate: (_ from: Int) -> Bool
    public var onComplete: () -> Void
    public var content: Content
    
    @State private var steps: [StepperStep] = []
    
    public init(
        currentStepId: Binding<Int>,
        onNavigate: @escaping (_ from: Int) -> Bool = { _ in true },
        onComplete: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStepId = currentStepId
        self.onNavigate = onNavigate
        self.onComplete = onComplete
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            StepperHeaderView(
                currentStepId: $currentStepId,
                steps: steps,
                onNavigate: onNavigate
            )
            
            ZStack {
                content
                    .transition(.slide)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .environment(\.currentStepId, currentStepId)
            .onPreferenceChange(StepperPreferenceKey.self) { extractedSteps in
                if self.steps != extractedSteps {
                    self.steps = extractedSteps
                }
            }
            .safeAreaInset(edge: .bottom) {
                 StepperFooterView(
                    currentStepId: $currentStepId,
                    steps: steps,
                    onNavigate: onNavigate,
                    onComplete: onComplete
                 )
            }
        }
    }
}

#Preview {
    @Previewable @State var currentStepId: Int = 1
    
    StepperView(
        currentStepId: $currentStepId,
        onComplete: { print("Completed") }
    ) {
        Text("I am great")
            .stepItem(id: 1, title: "Who am I?")
        
        Text("Yes")
            .stepItem(id: 2, title: "Why?")
    }
}
