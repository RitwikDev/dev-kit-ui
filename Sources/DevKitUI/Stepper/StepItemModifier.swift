//
//  StepItemModifier.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

struct StepItemModifier: ViewModifier {
    let id: Int
    let title: String
    
    @Environment(\.currentStepId) private var currentStepId
    
    func body(content: Content) -> some View {
        ZStack {
            if currentStepId == id {
                content
            }
        }
        .background(
            Color.clear
                .preference(
                    key: StepperPreferenceKey.self,
                    value: [StepperStep(id: id, title: title)]
                )
        )
    }
}

public extension View {
    func stepItem(id: Int, title: String) -> some View {
        self.modifier(StepItemModifier(id: id, title: title))
    }
}
