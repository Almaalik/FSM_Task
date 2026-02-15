//
//  StatusBadge.swift
//  FSM
//
//  Created by AlMaalik's Mac on 14/02/26.
//


import SwiftUI

struct ServiceStatusBadge: View {
    
    let status: ServiceStatus
    
    var body: some View {
        HStack(spacing: 6) {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(status.color.opacity(0.25))
                .frame(width: 14, height: 14)
            
            Text(status.rawValue.capitalized)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(status.color.opacity(0.15))
        .foregroundColor(status.color)
        .clipShape(Capsule())
    }
}

