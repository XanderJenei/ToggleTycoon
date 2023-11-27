import SwiftUI

struct ToggleTycoonHomeView: View {
      @State private var isInspecting: Bool = false

      @State private var showScrollView: Bool = false
      @State private var scrollMaxHeight: CGFloat = 0

      @State private var showEnergyText: Bool = false
      @State private var energyTextOpacity: CGFloat = 0

      @Binding var energy: Int

      @State var toggle1IsOn: Bool = false

      @State var toggle2IsOn: Bool = false
      @State var toggle2IsAble: Bool = false
      @State var toggle2CanAfford: Bool = false
      @State var toggle2Timer = 0.0

      let toggle2Cost: Int = 15
      let toggle2EnergyAmount: Int = 2
      let toggle2Text: String = "$2 per toggle"
      let toggle2Width: CGFloat = 64
      var toggle2Height: CGFloat = 32
      let toggle2activeColor: Color = .mint
      let toggle2duration: Double = 0.4
      let toggle2cooldownOffset: Double = 0.0


      @State var toggle3IsOn: Bool = false
      @State var toggle3IsAble: Bool = false
      @State var toggle3CanAfford: Bool = false
      @State var toggle3Timer = 0.0

      let toggle3Cost: Int = 50
      let toggle3EnergyAmount: Int = 4
      let toggle3Text: String = "$4 per toggle"
      let toggle3Width: CGFloat = 100
      var toggle3Height: CGFloat = 36
      let toggle3activeColor: Color = .blue
      let toggle3duration: Double = 0.8
      let toggle3cooldownOffset: Double = 0.1

      
      @State var toggle4IsOn: Bool = false
      @State var toggle4IsAble: Bool = false
      @State var toggle4CanAfford: Bool = false
      @State var toggle4Timer = 0.0

      let toggle4Cost: Int = 150
      let toggle4EnergyAmount: Int = 8
      let toggle4Text: String = "$8 per toggle"
      let toggle4Width: CGFloat = 128
      var toggle4Height: CGFloat = 28
      let toggle4activeColor: Color = .purple
      let toggle4duration: Double = 1.1
      let toggle4cooldownOffset: Double = 0.1


      var body: some View {
            VStack {
                  VStack {
                        Text("$" + String(energy))
                              .opacity(energyTextOpacity)
                              .font(.title)
                              .fontWeight(.bold)

                        Toggle(isOn: $toggle1IsOn) {
                        }
                        .onChange(of: toggle1IsOn) {
                              mainToggle(toggleState: toggle1IsOn)
                        }
                        .labelsHidden()
                        .toggleStyle(.switch)
                  }
                  .padding()

                  ScrollView {
                        VStack {
                              VStack {
                                    HStack {
                                          CustomToggleView(energy: $energy,
                                                           isOn: $toggle2IsOn,
                                                           toggleTimer: $toggle2Timer,
                                                           toggleAble: $toggle2IsAble,
                                                           energyAmount: toggle2EnergyAmount,
                                                           toggleWidth: toggle2Width,
                                                           toggleHeight: toggle2Height,
                                                           toggleText: toggle2Text,
                                                           activeColor: toggle2activeColor,
                                                           duration: toggle2duration, 
                                                           cooldownOffset: toggle2cooldownOffset)

                                          Spacer()
                                          
                                          Button {
                                                isInspecting.toggle()
                                          } label: {
                                                Label("Inspect", systemImage: "plus.circle")
                                          }

                                          BuyButtonView(energy: $energy, toggleCost: toggle2Cost, toggleAbility: $toggle2IsAble, toggleCanAfford: $toggle2CanAfford)
                                    }
                              }
                              .padding()




                              VStack {
                                    HStack {
                                          CustomToggleView(energy: $energy,
                                                           isOn: $toggle3IsOn,
                                                           toggleTimer: $toggle3Timer,
                                                           toggleAble: $toggle3IsAble,
                                                           energyAmount: toggle3EnergyAmount,
                                                           toggleWidth: toggle3Width,
                                                           toggleHeight: toggle3Height,
                                                           toggleText: toggle3Text,
                                                           activeColor: toggle3activeColor,
                                                           duration: toggle3duration,
                                                           cooldownOffset: toggle3cooldownOffset)

                                          Spacer()
                                          
                                          BuyButtonView(energy: $energy, toggleCost: toggle3Cost, toggleAbility: $toggle3IsAble, toggleCanAfford: $toggle3CanAfford)
                                    }
                              }
                              .padding()


                              VStack {
                                    HStack {
                                          CustomToggleView(energy: $energy, 
                                                           isOn: $toggle4IsOn,
                                                           toggleTimer: $toggle4Timer,
                                                           toggleAble: $toggle4IsAble,
                                                           energyAmount: toggle4EnergyAmount,
                                                           toggleWidth: toggle4Width,
                                                           toggleHeight: toggle4Height,
                                                           toggleText: toggle4Text,
                                                           activeColor: toggle4activeColor,
                                                           duration: toggle4duration,
                                                           cooldownOffset: toggle4cooldownOffset)

                                          Spacer()

                                          BuyButtonView(energy: $energy, toggleCost: toggle4Cost, toggleAbility: $toggle4IsAble, toggleCanAfford: $toggle4CanAfford)
                                    }
                              }
                              .padding()
                        }
                  }
                  .frame(maxWidth: .infinity, maxHeight: scrollMaxHeight, alignment: .top)
                  .background(Material.thin)
            }
            .onChange(of: energy) {
                  onEnergyChange()
            }
            .inspector(isPresented: $isInspecting){

            }

      }

      func onEnergyChange() {
            toggle2CanAfford = energy >= toggle2Cost
            toggle3CanAfford = energy >= toggle3Cost
            toggle4CanAfford = energy >= toggle4Cost

            if (!showScrollView) {
                  if (energy > 1) {
                        showScrollView = true
                        withAnimation(.spring(duration: 2.0)) {
                              scrollMaxHeight = .infinity
                        }
                  }
            }

            if (!showEnergyText) {
                  withAnimation(.easeInOut(duration: 1.0)) {
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

struct ContentView_Previews: PreviewProvider {

      struct ContentViewContainer: View {
            @State private var energy: Int = 150

            var body: some View {
                  ToggleTycoonHomeView(energy: $energy)
            }
      }

      static var previews: some View {
            
            ContentViewContainer()
      }
}
