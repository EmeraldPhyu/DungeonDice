//
//  ContentView.swift
//  DungeonDice
//
//  Created by Emerald on 24/10/24.
//

import SwiftUI

struct ContentView: View {
	
	@State private var resultMessage = ""
	var body: some View {
			VStack {
				titleView
				
				Spacer()
				
				Image("dungeonsDragon")
					.resizable()
					.scaledToFit()
				
				Spacer()
				
				resultMessageView
				
				Spacer()
				
				ButtonLayout(resultMessage: $resultMessage)
				
			}.padding()
	}
}

struct RedAndCyanView: View {
	var body: some View {
		ZStack {
			Color(.red)
			Rectangle()
				.fill()
				.frame(width: 100, height: 100)
		}
	}
}

extension ContentView {
	private var titleView : some View {
		Text("Dungeon Dice")
			.font(.largeTitle)
		/*.font(Font.custom("Snell Roundhand", size: 60))*/
			.fontWeight(.black)
			.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
			.foregroundStyle(.red)
	}
	private var resultMessageView : some View {
		Text(resultMessage)
			.font(.largeTitle)
			.fontWeight(.medium)
			.frame(height: 150)
			.multilineTextAlignment(.center)
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
//#Preview {
//	ContentView()
//}

