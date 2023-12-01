import SwiftUI

struct ToggleTycoonHomeView: View {
	@Binding var energy: Int
	@Binding var toggles: [CustomToggle]

      @State var showScrollView: Bool = false
      @State var scrollMaxHeight: CGFloat = 0
	@State var reverseScrollMaxHeight: CGFloat = 360

      @State var showEnergyText: Bool = false
      @State var energyTextOpacity: CGFloat = 0

	@State var mainIsOn: Bool = false
	@State var mainToggleCount: Int = 1

	var body: some View {
		VStack (){


			Button("Free Money") { energy += 1 }

			VStack {Spacer()}
				.frame(maxHeight: showScrollView ? .infinity : reverseScrollMaxHeight)

			VStack {
				Text("$" + String(energy))
					.opacity(energyTextOpacity)
					.font(.title)
					.fontWeight(.bold)
				
				HStack{
					ForEach(0..<mainToggleCount, id: \.self) { index in
						Toggle(isOn: $mainIsOn) {
						}
						.onChange(of: mainIsOn) {
							mainToggle(toggleState: mainIsOn)
						}
						.labelsHidden()
						.toggleStyle(.switch)
					}
				}
			}
			.padding()

			VStack {Spacer()}
			.frame(maxHeight: reverseScrollMaxHeight)

			ScrollView {
				VStack {
					ForEach (toggles.indices, id: \.self) { index in
						ZStack {
							Rectangle().fill(toggles[index].activeColor)
								.opacity(toggles[index].isOn ? 0.1 : 0)
							HStack {
								InspectToggleView(toggles: $toggles, index: index)
								
								Spacer()
								CustomToggleView(energy: $energy, toggle: $toggles[index])
								Spacer()
								
								BuyButtonView(energy: $energy, toggle: $toggles[index])
							}
							
							.padding(6)
						}
					}
				}
			}
			.frame(maxWidth: .infinity, minHeight: scrollMaxHeight / 2, maxHeight: scrollMaxHeight, alignment: .top)
			.background(Material.ultraThin)
			.opacity(showScrollView ? 1.0 : 0.0)
		}
		.fontDesign(.rounded)
		.onChange(of: energy) {
			onEnergyChange()

			print($toggles[0].upgradeAutoOffCanAfford)
		}
		.inspector(isPresented: $toggles[0].isInspecting) {
			VStack {
				HStack{
					CustomUpgradeToggleView(upgrade: $toggles[0].upgradeAutoOff, upgradeAble: $toggles[0].upgradeAutoOffAble)
					Text("Auto Off").font(.callout).fontWeight(.thin).opacity(toggles[0].upgradeAutoOffAble ? 0.4 : 0.2)
					Spacer()
					BuyUpgradeButtonView(energy: $energy, upgradeAble: $toggles[0].upgradeAutoOffAble, upgradeCanAfford: $toggles[0].upgradeAutoOffCanAfford, upgradeShowBuyButton: $toggles[0].upgradeAutoOffShowBuyButton, upgradeCost: toggles[0].upgradeAutoOffCost)
				}
				.padding(6)
				Spacer()
			}
			.presentationDetents([.height(180)])
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
			toggles[index].upgradeAutoOffCanAfford = energy >= toggles[index].upgradeAutoOffCost

		}

            if (!showScrollView) {
                  if (energy > 1) {
				spawnScrollView()
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

	func spawnScrollView() {
		withAnimation(.easeOut(duration: 1.0)) {
			showScrollView = true
			scrollMaxHeight = 360
			reverseScrollMaxHeight = 0
		}
	}
}
#Preview {
	ToggleTycoonPreviewContainer()
}
