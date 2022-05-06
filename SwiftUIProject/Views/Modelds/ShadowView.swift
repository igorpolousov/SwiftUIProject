//
//  ShadowView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//


import SwiftUI

 struct CircleShadow: ViewModifier {
     let shadowColor: Color
     let shadowRadius: CGFloat

     func body(content: Content) -> some View {
         content
             .clipShape(Circle())
             .shadow(color: shadowColor, radius: shadowRadius)
             .overlay(Circle().stroke(shadowColor, lineWidth: 1))
     }
 }
