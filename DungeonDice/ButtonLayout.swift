//
//  ButtonLayout.swift
//  DungeonDice
//
//  Created by Emerald on 20/11/24.
//

import SwiftUI

struct ButtonLayout: View {
	enum Dice : Int , CaseIterable {
		case four = 4
		case six = 6
		case eight = 8
		case ten = 10
		case twelve = 12
		case twenty = 20
		case fifty = 50
		case hundred = 100
		case hundredAndTwo = 102
		
		func roll()->Int{
			return Int.random(in: 1...self.rawValue)
		}
	}
	
	// A prefernce key struct which we will use to pass values up from child to parent view
	struct DeviceWithPreferenceKey: PreferenceKey {
		static var defaultValue: CGFloat = 0
		static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
			value = nextValue()
		}
		typealias Value = CGFloat
	}
	
	@State private var buttonsLeftOver = 0 // #
	@Binding var resultMessage : String
	
	let spacing : CGFloat = 0 //Bet buttons
	let buttonWidth : CGFloat = 102
	let horizontalPadding : CGFloat = 16

	var body: some View {
		//Calculate #items that fit in a row
		//Left over item will be put inside HStack to align center
		VStack {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
				ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
					Button("\(dice.rawValue)-sided"){
						resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
					}.frame(width: buttonWidth)
				}
			}
			.buttonStyle(.borderedProminent)
			.tint(.red)
			
			HStack{
				ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
					Button("\(dice.rawValue)-sided"){
						resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
					}.frame(width: buttonWidth)
				}.buttonStyle(.borderedProminent)
					.tint(.red)
			}
		}
		.border(.red)
		.overlay {
			GeometryReader { geo in
				Color.clear
					.preference(key: DeviceWithPreferenceKey.self, value: geo.size.width)
			}
		}
		.onPreferenceChange(DeviceWithPreferenceKey.self)
		{deviceWidth in arrangeGridItems(deviceWidth: deviceWidth)}
	}
	
	func arrangeGridItems(deviceWidth: CGFloat){
		var screenWidth = deviceWidth - horizontalPadding * 2
		//padding on both sides
		if Dice.allCases.count > 1 {
			screenWidth += spacing
		}
		//Calculate numOfButtonPerRow as an Int
		let numberOfButtonsPerRow = Int(screenWidth) / Int (buttonWidth + spacing)
		buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
	}
}

#Preview {
	ButtonLayout(resultMessage: .constant(""))
}
