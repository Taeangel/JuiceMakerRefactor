//
//  Fruit.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Foundation
import UIKit

enum Fruit: Int, CaseIterable {
  case strawberry = 0
  case banana
  case pineapple
  case kiwi
  case mango
  
  var name: String {
    switch self {
    case .strawberry:
      return "딸기"
    case .banana:
      return "바나나"
    case .pineapple:
      return "파인애플"
    case .kiwi:
      return "키위"
    case .mango:
      return "망고"
    }
  }
}
