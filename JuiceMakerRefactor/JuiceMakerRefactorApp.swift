//
//  JuiceMakerRefactorApp.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import SwiftUI

@main
struct JuiceMakerRefactorApp: App {
  let viewRouter = ViewRouter()
  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(viewRouter)
    }
  }
}
