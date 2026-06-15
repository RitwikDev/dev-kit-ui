//
//  StepItemModifier.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

struct StepItemModifier: ViewModifier {
    let index: Int
    let title: String
    
    @Environment(\.currentStepIndex) private var currentStepIndex
    
    func body(content: Content) -> some View {
        ZStack {
            if currentStepIndex == index {
                content
            }
        }
        .background(
            Color.clear
                .preference(
                    key: StepperPreferenceKey.self,
                    value: [StepperStep(id: index, title: title)]
                )
        )
    }
}

public extension View {
    func stepItem(index: Int, title: String) -> some View {
        self.modifier(StepItemModifier(index: index, title: title))
    }
}
