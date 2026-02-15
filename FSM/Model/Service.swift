//
//  Service.swift
//  FSM
//
//  Created by AlMaalik's Mac on 13/02/26.
//

import Foundation
import SwiftUI

enum ServiceStatus: String {
    case planned
    case scheduled
    case confirmed
    case approved
    
    var color: Color {
        switch self {
        case .planned: return .blue
        case .scheduled: return .green
        case .confirmed: return .indigo
        case .approved: return .orange
        }
    }
}

struct Service: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let customerName: String
    let description: String
    let scheduledDate: Date
    let status: ServiceStatus
    let latitude: Double
    let longitude: Double
    let notes: String
}

