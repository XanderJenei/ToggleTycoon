import SwiftUI

struct ToggleTycoonHomeView: View {
	@Binding var energy: Int
	@Binding var toggles: [CustomToggle]

      @State var showScrollView: Bool = false
      @State var scrollMaxHeight: CGFloat = 0

      @State var showEnergyText: Bool = false
      @State var energyTextOpacity: CGFloat = 0

	@State var mainIsOn: Bool = false

	var body: some View {
		VStack {
			VStack {
				Text("$" + String(energy))
					.opacity(energyTextOpacity)
					.font(.title)
					.fontWeight(.bold)

				Toggle(isOn: $mainIsOn) {
				}
				.onChange(of: mainIsOn) {
					mainToggle(toggleState: mainIsOn)
				}
				.labelsHidden()
				.toggleStyle(.switch)
			}
			.padding()

			ScrollView {
				VStack {
					ForEach (toggles.indices, id: \.self) { index in
						ZStack {
							Rectangle().fill(toggles[index].activeColor)
								.opacity(toggles[index].isOn ? 0.1 : 0)
							HStack {
								InspectToggleView(toggles: $toggles, index: index)

								CustomToggleView(energy: $energy, toggle: $toggles[index])

								Spacer()

								BuyButtonView(energy: $energy, toggle: $toggles[index])
							}

							.padding(6)
						}
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: scrollMaxHeight, alignment: .top)
			.background(Material.ultraThin)
		}
		.fontDesign(.rounded)
		.onChange(of: energy) {
			onEnergyChange()
		}
		.inspector(isPresented: $toggles[0].isInspecting) {
			Text("0")
		}
		.inspector(isPresented: $toggles[1].isInspecting) {
			Text("1")

		}
		.inspector(isPresented: $toggles[2].isInspecting) {
			Text("2")

		}
		.inspector(isPresented: $toggles[3].isInspecting) {
			Text("3")

		}
		.inspector(isPresented: $toggles[4].isInspecting) {
			Text("4")

		}
	}

	
      func onEnergyChange() {
		for index in toggles.indices {
			toggles[index].canAfford = energy >= toggles[index].cost
		}

            if (!showScrollView) {
                  if (energy > 1) {
				withAnimation(.easeOut(duration: 1.0)) {
					showScrollView = true
					scrollMaxHeight = 1000
                        }
                  }
            }

            if (!showEnergyText) {
                  withAnimation(.easeOut(duration: 1.0)) {
                        energyTextOpacity = 1.0
                  }
                  showEnergyText = true
            }
      }

      func mainToggle(toggleState: Bool) {
            if(toggleState == true) {
                  energy += 1
            }
      }
}
