//
//  OnBoardingImageShape.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//
import Foundation
import SwiftUI

struct OnBoardingImageShape: Shape {

    func path(in rect: CGRect) -> Path {

       let cornerRadius: CGFloat = 20

        var path = Path()

        path.move(to: CGPoint(x: rect.minX ,y: rect.minY + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius ,y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX , y: rect.minY + cornerRadius), control: CGPoint(x: rect.maxX, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX ,y: rect.maxY - 40 - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius , y: rect.maxY - 40), control: CGPoint(x: rect.maxX, y: rect.maxY - 40))

        path.addLine(to: CGPoint(x: rect.minX + cornerRadius ,y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX , y: rect.maxY - cornerRadius), control: CGPoint(x: rect.minX, y: rect.maxY))

        path.addLine(to: CGPoint(x: rect.minX ,y: rect.minY + cornerRadius))

        path.closeSubpath()

        return path
    }
}

