//
//  StepperFooterView.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

struct StepperFooterView: View {
    @Binding var currentStepIndex: Int
    var steps: [StepperStep] = []
    var onNavigate: (_ from: Int) -> Bool = { _  in true }
    var onComplete: () -> Void
        
    private var isFirstStep: Bool {
        steps.first?.id == currentStepIndex
    }
    
    private var isLastStep: Bool {
        steps.last?.id == currentStepIndex
    }
    
    var body: some View {
        HStack {
            if !isFirstStep {
                Button {
                    if onNavigate(currentStepIndex) {
                        currentStepIndex = currentStepIndex - 1
                    }
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                        .padding()
                }
                .conditionalButtonStyle(isLastStep: false)
            }
            
            Spacer()
            
            Button {
                if isLastStep {
                    onComplete()
                } else {
                    if onNavigate(currentStepIndex) {
                        currentStepIndex = currentStepIndex + 1
                    }
                }
            } label: {
                Label("Next", systemImage: isLastStep ? "checkmark" : "chevron.right")
                    .padding()
                    .contentTransition(.symbolEffect(.replace))
            }
            .conditionalButtonStyle(isLastStep: isLastStep)
        }
        .labelStyle(.iconOnly)
        .padding(.horizontal)
    }
}

extension View {
    @ViewBuilder
    func conditionalButtonStyle(isLastStep: Bool) -> some View {
        if #available(iOS 26.0, *) {
            if isLastStep {
                self.buttonStyle(.glassProminent)
                    .tint(.green)
            } else {
                self.buttonStyle(.glass)
            }
        } else {
            self.buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(isLastStep ? .green : .blue)
        }
    }
}

#Preview {
    StepperFooterView(
        currentStepIndex: .constant(1),
        steps: [
            .init(id: 1, title: "Step 1"),
            .init(id: 2, title: "Step 2"),
            .init(id: 3, title: "Step 3"),
        ],
        onComplete: { },
    )
}
