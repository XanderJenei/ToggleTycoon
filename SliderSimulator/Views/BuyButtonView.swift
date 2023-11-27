import SwiftUI

struct BuyButtonView: View {
      @Binding var energy: Int
      let toggleCost: Int

      @Binding var toggleAbility: Bool
      @Binding var toggleCanAfford: Bool

      var body: some View {
            Button("$" + String(toggleCost)) {
                  buySlider(toggleAbility: $toggleAbility, cost: toggleCost)
            }
            .disabled(!toggleCanAfford)
      }

      func buySlider(toggleAbility: Binding<Bool>, cost: Int) {
            if (energy >= cost) {
                  energy -= cost
                  toggleAbility.wrappedValue = true
            }
      }
}


#Preview {
      BuyButtonView(energy: .constant(10), toggleCost: 10, toggleAbility: .constant(true), toggleCanAfford: .constant(true))
}
