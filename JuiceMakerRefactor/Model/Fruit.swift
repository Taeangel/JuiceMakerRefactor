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
  
  var image: UIImage {
    switch self {
    case .strawberry:
      return UIImage(named: "딸기") ?? UIImage()
    case .banana:
      return UIImage(named: "바나나") ?? UIImage()
    case .pineapple:
      return UIImage(named: "파인애플") ?? UIImage()
    case .kiwi:
      return UIImage(named: "키위") ?? UIImage()
    case .mango:
      return UIImage(named: "망고") ?? UIImage()
    }
  }
}
