import SwiftUI

struct CustomToggleView: View {
      @Binding var energy: Int

      @Binding var isOn: Bool
      @Binding var toggleTimer: Double

      @Binding var toggleAble: Bool

      var energyAmount: Int?

      var toggleWidth: CGFloat?
      var toggleHeight: CGFloat?

      var toggleText: String?
      var activeColor: Color?
      var duration: Double?
      var cooldownOffset: Double?

      let newGesture = TapGesture().onEnded {
            print("Gesture on VStack.")
      }

      var body: some View {
            Toggle(isOn: $isOn) {
            }
            .toggleStyle(CustomToggleStyle(toggleTimer: $toggleTimer,
                                           toggleAble: $toggleAble,
                                           frameWidth: toggleWidth ?? 64,
                                           frameHeight: toggleHeight ?? 32,
                                           activeColor: activeColor ?? .green,
                                           toggleText: toggleText ?? nil,
                                           duration: duration ?? 0.4,
                                           cooldownOffset: cooldownOffset ?? 0.2))
            .onChange(of: isOn) {
                  customToggle(toggleState: isOn, energyAmount: energyAmount ?? 1)
            }
            .disabled(!toggleAble)
            .simultaneousGesture(newGesture)
      }

      func customToggle(toggleState: Bool, energyAmount: Int) {
            if(toggleState == true) {
                  UIImpactFeedbackGenerator(style: .rigid).impactOccurred()

                  energy += energyAmount
            } else {
                  UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
      }
}


struct CustomToggle_Previews: PreviewProvider {

      struct CustomToggleContainer: View {
            @State private var energy = 20

            @State private var isOn1 = false
            @State private var toggleTimer1 = 0.0
            @State private var toggleAble1 = true
            @State private var isOn2 = false
            @State private var toggleTimer2 = 0.0
            @State private var toggleAble2 = true

            var body: some View {
                  VStack{
                        CustomToggleView(energy: $energy, isOn: $isOn1, toggleTimer: $toggleTimer1, toggleAble: $toggleAble1)
                        CustomToggleView(energy: $energy, isOn: $isOn2, toggleTimer: $toggleTimer2, toggleAble: $toggleAble2)
                  }
            }
      }


      static var previews: some View {
            CustomToggleContainer()
      }
}

