//
//  StepperHeaderView.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

struct StepperHeaderView: View {
    @Binding var currentStepId: Int
    var steps: [StepperStep]
    var onNavigate: (_ from: Int) -> Bool = { _  in true}
    
    private var currentStep: StepperStep? {
        steps.first { $0.id == currentStepId }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            GeometryReader { geometry in
                HStack(spacing: 4) {
                    ForEach(steps) { step in
                        let isCurrent = step.id == currentStepId
                        
                        HeaderView(
                            step: step,
                            isCurrent: isCurrent,
                            containerWidth: geometry.size.width,
                            stepsCount: steps.count
                        )
                        .frame(maxWidth: .infinity)
                        .animation(.spring(duration: 0.25), value: isCurrent)
                        .onTapGesture {
                            let shouldNavigate = step.id != currentStepId
                            && onNavigate(currentStepId)
                            
                            if shouldNavigate {
                                currentStepId = step.id
                            }
                        }
                    }
                }
            }
            .frame(height: 10)
            
            if let currentStep {
                Text(currentStep.title)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}

struct HeaderView: View {
    let step: StepperStep
    let isCurrent: Bool
    let containerWidth: CGFloat
    let stepsCount: Int
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(isCurrent ? .blue : .gray)
                .frame(
                    width: isCurrent ? containerWidth * 0.75 : (containerWidth * 0.25) / CGFloat(stepsCount),
                    height: 10
                )
                .opacity(0.8)
        }
    }
}

#Preview {
    StepperHeaderView(
        currentStepId: .constant(1),
        steps: [
            .init(id: 1, title: "Step 1"),
            .init(id: 2, title: "Step 2"),
            .init(id: 3, title: "Step 3"),
        ]
    )
}
