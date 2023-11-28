import SwiftUI

struct BuyButtonView: View {
	@Binding var showBuyButton: Bool

      @Binding var energy: Int
      @Binding var toggleAbility: Bool
      @Binding var toggleCanAfford: Bool

	@State var finalSize: CGFloat = 0
	@State var opacity: Double = 0.0

	let toggleCost: Int


	var body: some View {
		ZStack{
			Circle()
				.fill(.white)
				.shadow(color: Color(white: 0.8, opacity: 1.0), radius: 2, y: 1)
				.padding(2)
				.frame(width: finalSize, height: finalSize)

			Button("$" + toggleCost.formatted(.number.notation(.compactName))) {
				buySlider(toggleAbility: $toggleAbility, cost: toggleCost)

				despawnButton()

				UIImpactFeedbackGenerator(style: .soft).impactOccurred()
			}
			.opacity(opacity)
		}
		.disabled(!toggleCanAfford || toggleAbility)

		.onChange(of: showBuyButton) {
			if (showBuyButton) {
				spawnButton()
			} else {
				despawnButton()
			}
		}
		.onChange(of: energy) {
			if(!toggleAbility){
				if (energy * 2 >= toggleCost / 2) {
					showBuyButton = true
				} else {
					showBuyButton = false
				}
			}
		}
	}

	func spawnButton() {
		withAnimation(.easeOut(duration: 2.0)) {
			opacity = 1.0
		}
		withAnimation(.spring(duration: 1.0, bounce: 0.5)) {
			finalSize = 12.0 + 16.0 * Double(toggleCost.formatted(.number.notation(.compactName)).count)
		}
	}

	func despawnButton() {
		withAnimation(.easeIn(duration: 0.1)) {
			opacity = 0.0
		}
		withAnimation(.spring(duration: 1.0, bounce: 0.5)) {
			finalSize = 0
		}
	}

      func buySlider(toggleAbility: Binding<Bool>, cost: Int) {
            if (energy >= cost) {
                  energy -= cost
                  toggleAbility.wrappedValue = true
            }
      }
}


struct BuyButton_Previews: PreviewProvider {

	struct BuyButtonContainer: View {
		@State private var energy = 20
		@State private var ability = false
		@State private var afford = true
		@State private var showButton = false

		var body: some View {
			VStack{
				BuyButtonView(showBuyButton: $showButton, energy: $energy, toggleAbility: $ability, toggleCanAfford: $afford, toggleCost: 100)

				Toggle("Show Button", isOn: $showButton).labelsHidden()
			}
		}
	}


	static var previews: some View {
		BuyButtonContainer()
	}
}
