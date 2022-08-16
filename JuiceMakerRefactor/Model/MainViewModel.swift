//
//  FruitStore.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Foundation
import UIKit

class MainViewModel: ObservableObject {
  private(set) var stock = [Fruit: Int]()
  
  init() {
    initsetting()
  }
  
  private func initsetting() {
    let defaultCount = 10
    
    for fruit in Fruit.allCases {
      stock[fruit] = defaultCount
    }
  }
  
  private func checkStock(of fruits: [Fruit: Int]) -> Bool {
    return fruits.keys
      .filter { stock.keys.contains($0) }
      .count == fruits.count
  }
  
  private func canMake(_ fruits: [Fruit: Int]) -> Bool {
    return self.stock
      .merging(fruits) { $0 - $1 }
      .filter { $0.value < Int.zero }
      .count == Int.zero
  }
  
  private func consumeStock(of fruits: [Fruit: Int]) {
    stock.merge(fruits) { $0 - $1 }
  }
  
  func setStock(of fruit: Fruit, _ value: Int) {
    stock[fruit] = value
  }
  
  func make(_ juice: Juice) -> Result<Juice, MakeJuiceError> {
    let recipe = juice.recipe
    guard checkStock(of: recipe) else {
      return .failure(.notExistFruit)
    }
    guard canMake(recipe) else {
      return .failure(.outOfStock)
    }
    consumeStock(of: recipe)
    return .success(juice)
  }
}