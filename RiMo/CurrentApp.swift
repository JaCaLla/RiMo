//
//  CurrentApp.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

struct CurrentApp {
    var dataManager: DataManager
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
}

@MainActor
var currentApp = CurrentApp()

