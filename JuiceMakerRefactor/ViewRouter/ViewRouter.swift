//
//  ViewRouter.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/26.
//

import Combine

class ViewRouter : ObservableObject{
  
  let objectWillChange: PassthroughSubject<ViewRouter,Never>
  
  init(
    objectWillChange: PassthroughSubject<ViewRouter,Never> = PassthroughSubject<ViewRouter,Never>()) {
    self.objectWillChange = objectWillChange
  }
  
  var currentPage: String = "JuiceOrderView" {
    didSet{
      objectWillChange.send(self)
    }
  }
}
