//
//  BoardingPassViewModel.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import Foundation

struct BoardingPassViewModel {
    var transportType: TransportType
    var passStatus: PassStatus
    var passNumber: String
    var initialDepartureTime: Date
    var initialArrivarlTime: Date
    var actualDepartureTime: Date
    var actualArrivalTime: Date
    var departureAirportCode: String
    var arrivalAirportCode: String
    var departureAirportTitle: String
    var arrivalAirportTitle: String
    var pickupContact: PickupContactViewModel?
}

enum PassStatus {
    case gateChanged
    case onTime
}

enum TransportType {
    case airplane
}
