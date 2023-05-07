//
//  weatherWidgetBundle.swift
//  weatherWidget
//
//  Created by Salii on 4/24/23.
//

import WidgetKit
import SwiftUI

@main
struct weatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        weatherWidget()
        weatherWidgetLiveActivity()
    }
}
