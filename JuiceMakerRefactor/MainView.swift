//
//  ContentView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import SwiftUI
import Combine


struct MainView: View {
  @StateObject var viewModel = MainViewModel()
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          ForEach(viewModel.fruitInformation, id: \.self) { fruit in
            VStack{
              Image(uiImage: UIImage(named: fruit.name) ?? UIImage())
                .resizable()
                .frame(width: 100, height: 100)
              Text("\(viewModel.stock[fruit] ?? 0)")
              
            }
            .padding(30)
          }
        }
        
        HStack {
          ForEach(viewModel.JuiceInformation, id: \.self) { juice in
            Button(action: {
              viewModel.make(juice)
           }, label: {
             Text("\(juice.rawValue) 버튼")
           })
          }
          .padding(30)
        }
      }
      .navigationTitle("맛잇는 쥬스를 만들어 드려요!")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            EditView(service: viewModel.fruitModel)
          }, label: {
            Text("edit")
          })
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .previewInterfaceOrientation(.landscapeRight)

  }
}


