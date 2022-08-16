//
//  ContentView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel = MainViewModel()
  var body: some View {
    NavigationView {
      VStack {

      }
      .navigationTitle("맛잇는 쥬스를 만들어 드려요!")
    }
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
