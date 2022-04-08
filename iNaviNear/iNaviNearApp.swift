//
//  iNaviNearApp.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/04.
//

import SwiftUI
import iNaviMaps

@main
struct iNaviNearApp: App {
    
    
    init() {
        // INVMap 앱키 설정
        INVMapSdk.sharedInstance().appKey = KEY.AppKey
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
