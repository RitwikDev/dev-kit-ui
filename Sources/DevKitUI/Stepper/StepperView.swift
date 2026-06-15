//
//  StepperView.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

public struct StepperView<Content: View>: View {
    @Binding public var currentStepIndex: Int
    public var onNavigate: (_ from: Int) -> Bool
    public var onComplete: () -> Void
    public var content: Content
    
    @State private var steps: [StepperStep] = []
    @State private var isMovingForward: Bool = true
    
    public init(
        currentStepIndex: Binding<Int>,
        onNavigate: @escaping (_ from: Int) -> Bool = { _ in true },
        onComplete: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self._currentStepIndex = currentStepIndex
        self.onNavigate = onNavigate
        self.onComplete = onComplete
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            StepperHeaderView(
                currentStepIndex: $currentStepIndex,
                steps: steps,
                onNavigate: onNavigate
            )
            
            ZStack {
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.spring(response: 0.4, dampingFraction: 0.9), value: currentStepIndex)
            .environment(\.currentStepIndex, currentStepIndex)
            .onPreferenceChange(StepperPreferenceKey.self) { extractedSteps in
                if self.steps != extractedSteps {
                    self.steps = extractedSteps
                }
            }
            .safeAreaInset(edge: .bottom) {
                 StepperFooterView(
                    currentStepIndex: $currentStepIndex,
                    steps: steps,
                    onNavigate: onNavigate,
                    onComplete: onComplete
                 )
            }
        }
    }
}

#Preview {
    @Previewable @State var currentStepIndex: Int = 1
    
    StepperView(
        currentStepIndex: $currentStepIndex,
        onComplete: { print("Completed") }
    ) {
        Form {
            Text("I am great")
        }
        .stepItem(index: 1, title: "Who am I?")
        
        ZStack {
            Text("Yes")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
        .stepItem(index: 2, title: "Why?")
        
        Text("No")
            .stepItem(index: 3, title: "True")
    }
}
