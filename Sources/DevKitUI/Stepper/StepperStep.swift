//
//  StepperStep.swift
//  Playground
//
//  Created by Ritwik Dev on 14/06/26.
//

import SwiftUI

public struct StepperStep: Equatable, Identifiable, Sendable {
    public let id: Int
    public let title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

struct StepperPreferenceKey: PreferenceKey {
    static let defaultValue: [StepperStep] = []
    
    static func reduce(value: inout [StepperStep], nextValue: () -> [StepperStep]) {
        value.append(contentsOf: nextValue())
    }
}

struct CurrentStepIndexKey: EnvironmentKey {
    static let defaultValue: Int = -1
}

extension EnvironmentValues {
    var currentStepIndex: Int {
        get { self[CurrentStepIndexKey.self] }
        set { self[CurrentStepIndexKey.self] = newValue }
    }
}
