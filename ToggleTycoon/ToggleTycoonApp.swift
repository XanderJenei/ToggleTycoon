import SwiftUI

struct CustomToggle: Identifiable, Equatable {
	let id = UUID()
	
	//State
	var isOn: Bool = false

	var cooldownTimer = 0.0

	var isAble: Bool = false

	var canAfford: Bool = false
	var showBuyButton: Bool = false

	var isInspecting: Bool = false

	//Constants
	let cost: Int
	let energyAmount: Int
	let text: String
	let width: CGFloat
	let height: CGFloat
	let activeColor: Color
	let duration: Double
	let cooldownOffset: Double

	
	//Upgrades
	//State
	var upgradeAutoOff: Bool = false
	var upgradeAutoOffAble: Bool = false
	var upgradeAutoOffCanAfford: Bool = false
	var upgradeAutoOffShowBuyButton: Bool = false


	//Constants
	var upgradeAutoOffCost: Int = 100

}

@main
struct ToggleTycoonApp: App {
      @State private var energy: Int = 0

	@State var toggles: [CustomToggle] = [
		//0
		CustomToggle(cost: 15,
				 energyAmount: 2,
				 text: "$2",
				 width: 64,
				 height: 32,
				 activeColor: .mint,
				 duration: 0.4,
				 cooldownOffset: 0.4,
				 upgradeAutoOffCost: 100),

		//1
		CustomToggle(cost: 50,
				 energyAmount: 4,
				 text: "$4",
				 width: 100,
				 height: 34,
				 activeColor: .blue,
				 duration: 0.8,
				 cooldownOffset: 0.1),

		//2
		CustomToggle(cost: 150,
				 energyAmount: 8,
				 text: "$8",
				 width: 128,
				 height: 30,
				 activeColor: .indigo,
				 duration: 1.0,
				 cooldownOffset: 0.0),

		//3
		CustomToggle(cost: 500,
				 energyAmount: 15,
				 text: "$15",
				 width: 58,
				 height: 26,
				 activeColor: .pink,
				 duration: 2.0,
				 cooldownOffset: 0.2),

		//4
		CustomToggle(cost: 1500,
				 energyAmount: 5,
				 text: "$5",
				 width: 68,
				 height: 36,
				 activeColor: .orange,
				 duration: 0.3,
				 cooldownOffset: 0.3)
	]

      var body: some Scene {
            WindowGroup {
			ToggleTycoonHomeView(energy: $energy, toggles: $toggles)
            }
      }
}

struct ToggleTycoonPreviewContainer: View {      
	@State private var energy: Int = 10000

	@State var toggles: [CustomToggle] = [
		//0
		CustomToggle(cost: 15,
				 energyAmount: 2,
				 text: "$2",
				 width: 64,
				 height: 32,
				 activeColor: .mint,
				 duration: 0.4,
				 cooldownOffset: 0.4),

		//1
		CustomToggle(cost: 50,
				 energyAmount: 4,
				 text: "$4",
				 width: 100,
				 height: 34,
				 activeColor: .blue,
				 duration: 0.8,
				 cooldownOffset: 0.1),

		//2
		CustomToggle(cost: 150,
				 energyAmount: 8,
				 text: "$8",
				 width: 128,
				 height: 30,
				 activeColor: .indigo,
				 duration: 1.0,
				 cooldownOffset: 0.0),

		//3
		CustomToggle(cost: 500,
				 energyAmount: 15,
				 text: "$15",
				 width: 58,
				 height: 26,
				 activeColor: .pink,
				 duration: 2.0,
				 cooldownOffset: 0.2),

		//4
		CustomToggle(cost: 1500,
				 energyAmount: 5,
				 text: "$5",
				 width: 68,
				 height: 36,
				 activeColor: .orange,
				 duration: 0.3,
				 cooldownOffset: 0.3)
	]

	var body: some View {
		VStack{
			ToggleTycoonHomeView(energy: $energy, toggles: $toggles)
		}
	}
}

struct ToggleTycoon_Previews: PreviewProvider {

	static var previews: some View {
		ToggleTycoonPreviewContainer()
	}
}
