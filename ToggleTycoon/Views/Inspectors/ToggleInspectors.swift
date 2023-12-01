import SwiftUI

struct ToggleInspector: View {
	@Binding var energy: Int
	@Binding var toggle: CustomToggle

	// Auto Toggle Off
	// Toggle off cooldown upgrades
	// Auto Toggle On (expensive)
	// Toggle on cooldown upgrades

    var body: some View {
	    VStack {
		    HStack{
			    CustomUpgradeToggleView(upgrade: $toggle.upgradeAutoOff, upgradeAble: $toggle.upgradeAutoOffAble)
			    Text("Auto Off").font(.callout).fontWeight(.thin).opacity(toggle.upgradeAutoOffAble ? 0.4 : 0.2)
			    Spacer()
			    BuyUpgradeButtonView(energy: $energy, upgradeAble: $toggle.upgradeAutoOffAble, upgradeCanAfford: $toggle.upgradeAutoOffCanAfford, upgradeCost: toggle.upgradeAutoOffCost)
		    }
		    .padding(6)
		    Spacer()
	    }
	    .presentationDetents([.height(180)])
    }
}
