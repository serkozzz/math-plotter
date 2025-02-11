//
//  Untitled.swift
//  MathPlotter
//
//  Created by Sergey Kozlov on 11.02.2025.
//
import Foundation
import Expression

class MathFunctionParser : Identifiable {
    private let strExpression: String // Явно указываем Expression из Expression

    init(expression: String) {
        self.strExpression = expression.lowercased()
    }

    func evaluate(x: Double) -> Double {
        let estrExpr = strExpression.replacingOccurrences(of: "x", with: "\(x)")
        let expression = NumericExpression(estrExpr, constants: ["pi": Double.pi, "e": M_E])
        do {
            return try expression.evaluate()
        } catch {
            return .nan
        }
    }
}
