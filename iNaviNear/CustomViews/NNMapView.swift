//
//  NNMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI
import iNaviMaps

// overlay Modifier
struct NNMapView: View {
    
    var mapView: CommonMapView = CommonMapView()
    
    var body: some View {
        
        ZStack {
            mapView
        }
        .overlay(SelfPositionButton(mapView: mapView.mapInstance)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
                 , alignment: .bottomTrailing
        )
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
