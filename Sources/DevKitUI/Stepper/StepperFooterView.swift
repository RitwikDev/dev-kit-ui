//
//  StepperFooterView.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

struct StepperFooterView: View {
    @Binding var currentStepId: Int
    var steps: [StepperStep] = []
    var onNavigate: (_ from: Int) -> Bool = { _  in true }
    var onComplete: () -> Void
    
    private var isFirstStep: Bool {
        steps.first?.id == currentStepId
    }
    
    private var isLastStep: Bool {
        steps.last?.id == currentStepId
    }
    
    var body: some View {
        HStack {
            if !isFirstStep {
                Button {
                    if onNavigate(currentStepId) {
                        currentStepId = currentStepId - 1
                    }
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                        .padding()
                }
            }
            
            Spacer()
            
            Button {
                if isLastStep {
                    onComplete()
                } else {
                    if onNavigate(currentStepId) {
                        currentStepId = currentStepId + 1
                    }
                }
            } label: {
                Label("Next", systemImage: isLastStep ? "checkmark" : "chevron.right")
                    .padding()
                    .contentTransition(.symbolEffect(.replace))
            }
            .tint(isLastStep ? .green : .blue)
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .tint(.blue)
        .padding(.horizontal)
    }
}

#Preview {
    StepperFooterView(
        currentStepId: .constant(1),
        steps: [
            .init(id: 1, title: "Step 1"),
            .init(id: 2, title: "Step 2"),
            .init(id: 3, title: "Step 3"),
        ],
        onComplete: { },
    )
}
