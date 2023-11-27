//
//  CustomSlider.swift
//  SliderSimulator
//
//  Created by Vincent Jenei on 11/26/23.
//

import SwiftUI

struct SecondaryToggleStyle: ToggleStyle {

      @Binding var secondaryToggleTimer: Double

      var activeColor: Color = .blue

      let MoneyPerToggleText: String?

      let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

      func makeBody(configuration: Configuration) -> some View {
            HStack {
                  RoundedRectangle(cornerRadius: 16)
                        .fill(configuration.isOn ? activeColor : Color(UIColor.systemFill))
                        .overlay {
                              Circle()
                                    .fill(.white)
                                    .padding(3)
                                    .shadow(radius: 2)
                                    .offset(x: configuration.isOn ? 17 : -17)
                        }
                        .frame(width: 64, height: 32)
                        .onTapGesture {
                              if(secondaryToggleTimer <= 0.2){
                                    withAnimation(.spring(duration: 0.4, bounce: 0.2)) {
                                          configuration.isOn.toggle()
                                          secondaryToggleTimer = 0.4
                                    }
                              }
                        }
                        .onReceive(timer) { _ in
                              if secondaryToggleTimer > 0.0 {
                                    secondaryToggleTimer -= 0.1
                              }
                        }
                  if(MoneyPerToggleText != nil) {
                        Text(MoneyPerToggleText ?? "").font(.caption).fontWeight(.thin)
                  }
            }
      }
}
struct TertiaryToggleStyle: ToggleStyle {

      @Binding var tertiaryToggleTimer: Double

      var activeColor: Color = .yellow

      let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

      let MoneyPerToggleText: String?

      func makeBody(configuration: Configuration) -> some View {
            HStack {
                  RoundedRectangle(cornerRadius: 16)
                        .fill(configuration.isOn ? activeColor : Color(UIColor.systemFill))
                        .overlay {
                              Circle()
                                    .fill(.white)
                                    .padding(3)
                                    .shadow(radius: 2)
                                    .offset(x: configuration.isOn ? 35 : -35)
                        }
                        .frame(width: 100, height: 32)
                        .onTapGesture {
                              if(tertiaryToggleTimer <= 0.3){
                                    withAnimation(.spring(duration: 0.8, bounce: 0.1)) {
                                          configuration.isOn.toggle()
                                          tertiaryToggleTimer = 0.8
                                    }
                              }
                        }
                        .onReceive(timer) { _ in
                              if tertiaryToggleTimer > 0.0 {
                                    tertiaryToggleTimer -= 0.1
                              }
                        }

                  if(MoneyPerToggleText != nil) {
                        Text(MoneyPerToggleText ?? "").font(.caption).fontWeight(.thin)
                  }
            }
      }
}
struct QuaternaryToggleStyle: ToggleStyle {

      @Binding var toggleTimer: Double

      var activeColor: Color = .yellow

      let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

      let MoneyPerToggleText: String?

      func makeBody(configuration: Configuration) -> some View {
            HStack {
                  RoundedRectangle(cornerRadius: 16)
                        .fill(configuration.isOn ? activeColor : Color(UIColor.systemFill))
                        .overlay {
                              Circle()
                                    .fill(.white)
                                    .padding(3)
                                    .shadow(radius: 2)
                                    .offset(x: configuration.isOn ? 67 : -67)
                        }
                        .frame(width: 164, height: 32)
                        .onTapGesture {
                              if(toggleTimer <= 0.5){
                                    withAnimation(.spring(duration: 1.6, bounce: 0.1)) {
                                          configuration.isOn.toggle()
                                          toggleTimer = 1.6
                                    }
                              }
                        }
                        .onReceive(timer) { _ in
                              if toggleTimer > 0.0 {
                                    toggleTimer -= 0.1
                              }
                        }

                  if(MoneyPerToggleText != nil) {
                        Text(MoneyPerToggleText ?? "").font(.caption).fontWeight(.thin)
                  }
            }
      }
}


struct ContentViews_Previews: PreviewProvider {

      struct ContentViewsContainer: View {
            @State private var isOn1 = false
            @State private var isOn2 = false
            @State private var isOn3 = false
            @State private var isOn4 = false


            @State private var secondaryToggleTimer = 0.0
            @State private var tertiaryToggleTimer = 0.0
            @State private var quaternaryToggleTimer = 0.0

            var body: some View {
                  VStack{
                        Toggle("Switch Me", isOn: $isOn1)
                              .labelsHidden()
                              .toggleStyle(.switch)
                        
                        Toggle("Switch Me", isOn: $isOn2)
                              .labelsHidden()
                              .toggleStyle(SecondaryToggleStyle(secondaryToggleTimer: $secondaryToggleTimer, activeColor: Color.green, MoneyPerToggleText: "$2 per toggle"))

                        Toggle("Switch Me", isOn: $isOn3)
                              .labelsHidden()
                              .toggleStyle(TertiaryToggleStyle(tertiaryToggleTimer: $tertiaryToggleTimer, activeColor: Color.green, MoneyPerToggleText: "$4 per toggle"))

                        Toggle("Switch Me", isOn: $isOn4)
                              .labelsHidden()
                              .toggleStyle(QuaternaryToggleStyle(toggleTimer: $quaternaryToggleTimer, activeColor: Color.green, MoneyPerToggleText: "$8 per toggle"))
                  }
            }
      }

      static var previews: some View {

            ContentViewsContainer()
      }
}

