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
			//Button("Free Money") { energy += 10 }

			VStack {
				Spacer()

				#if DEBUG
				HStack{
					Spacer()
					Text("                           ").font(.title)
					Spacer()
				}
				Spacer()
				#endif
			}
				.frame(maxHeight: showScrollView ? .infinity : reverseScrollMaxHeight)
				.onTapGesture {
					energy += 100
				}



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
					//List {
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
						//}
						//.onMove(perform: move)

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
			ToggleInspector(energy: $energy, toggle: $toggles[0])
		}

		.inspector(isPresented: $toggles[1].isInspecting) {
			ToggleInspector(energy: $energy, toggle: $toggles[1])
		}
		.inspector(isPresented: $toggles[2].isInspecting) {
			ToggleInspector(energy: $energy, toggle: $toggles[2])
		}
		.inspector(isPresented: $toggles[3].isInspecting) {
			ToggleInspector(energy: $energy, toggle: $toggles[3])
		}
		.inspector(isPresented: $toggles[4].isInspecting) {
			ToggleInspector(energy: $energy, toggle: $toggles[4])
		}
	}
	func move(from source: IndexSet, destination: Int) {
		toggles.move(fromOffsets: source, toOffset: destination)
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
